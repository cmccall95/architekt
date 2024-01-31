part of '../blueprint_page.dart';

class _PdfPreview extends StatelessWidget {
  const _PdfPreview();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        _RegionsList(),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                _PreviousButton(),
                SizedBox(width: 10),
                Expanded(
                  child: Center(
                    child: _Blueprint(),
                  ),
                ),
                SizedBox(width: 10),
                _NextButton(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _Blueprint extends ConsumerWidget {
  const _Blueprint();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pdf = ref.watch(blueprintPdfControllerProvider);
    return pdf.maybeWhen(
      orElse: () => const SizedBox.shrink(),
      data: (pdfProperties) {
        if (pdfProperties == null) {
          return const SizedBox.shrink();
        }

        final notifier = ref.watch(blueprintPdfControllerProvider.notifier);
        final pdfController = notifier.pdfController;
        if (pdfController == null) {
          return const SizedBox.shrink();
        }

        return AspectRatio(
          aspectRatio: pdfProperties.aspectRatio,
          child: Container(
            color: Colors.grey.shade200,
            child: LayoutBuilder(builder: (context, constraints) {
              final canvasWidth = constraints.maxWidth;
              final canvasHeight = constraints.maxHeight;

              return Stack(
                children: [
                  PdfView(
                    controller: pdfController,
                    physics: const NeverScrollableScrollPhysics(),
                    onDocumentError: (error) {
                      logger.e('Error loading document $error');
                    },
                  ),
                  _Canvas(
                    canvasWidth: canvasWidth,
                    canvasHeight: canvasHeight,
                  ),
                ],
              );
            }),
          ),
        );
      },
    );
  }
}

class _PreviousButton extends ConsumerWidget {
  const _PreviousButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pdf = ref.watch(blueprintPdfControllerProvider);
    final properties = pdf.valueOrNull;

    return Visibility(
      visible: properties != null && !properties.isFirstPage,
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      child: TextButton(
        onPressed: () {
          final notifier = ref.read(blueprintPdfControllerProvider.notifier);
          notifier.previousPage();
        },
        style: TextButton.styleFrom(
          foregroundColor: Colors.grey.shade600,
          minimumSize: const Size(56, 56),
          maximumSize: const Size(56, 56),
          backgroundColor: Colors.grey.shade200,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Icon(Icons.chevron_left_rounded),
      ),
    );
  }
}

class _NextButton extends ConsumerWidget {
  const _NextButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pdf = ref.watch(blueprintPdfControllerProvider);
    final properties = pdf.valueOrNull;

    return Visibility(
      visible: properties != null && !properties.isLastPage,
      maintainSize: true,
      maintainAnimation: true,
      maintainState: true,
      child: TextButton(
        onPressed: () {
          final notifier = ref.read(blueprintPdfControllerProvider.notifier);
          notifier.nextPage();
        },
        style: TextButton.styleFrom(
          foregroundColor: Colors.grey.shade600,
          minimumSize: const Size(56, 56),
          maximumSize: const Size(56, 56),
          backgroundColor: Colors.grey.shade200,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: const Icon(Icons.chevron_right_rounded),
      ),
    );
  }
}
