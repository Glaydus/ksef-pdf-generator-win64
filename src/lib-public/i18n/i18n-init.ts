import i18next from 'i18next';
import pl from './lang/pl.json';

export async function initI18next(): Promise<void> {
  if (!i18next.isInitialized) {
    await i18next.init({
      lng: 'pl',
      showSupportNotice: false,
      debug: false,
      resources: {
        pl: { translation: pl }
      },
    });
  }
}
