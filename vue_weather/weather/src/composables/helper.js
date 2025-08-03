export const getImage = (path) => {
    return new URL('../assets/images/icons/${path}.png', import.meta.url).href;

};