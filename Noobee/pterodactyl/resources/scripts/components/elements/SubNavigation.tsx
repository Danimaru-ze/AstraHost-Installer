import styled from 'styled-components/macro';
import tw, { theme } from 'twin.macro';

const SubNavigation = styled.div`
    ${tw`w-full bg-neutral-700/30 backdrop-blur overflow-x-auto`};

    & > div {
        ${tw`flex items-center text-sm mx-auto px-2 gap-x-9`};
        max-width: 1200px;

        & > a,
        & > div {
            ${tw`flex items-center gap-x-2 py-3 text-neutral-300 no-underline whitespace-nowrap transition-all duration-150 relative`};

            &:hover {
                ${tw`text-neutral-100`};
            }

            &:active,
            &.active {
                ${tw`text-neutral-50`};

                &::after{
                    content: '';
                    width: 100%;
                    height: 2px;
                    position: absolute;
                    bottom: 0;
                    background-color: white;
                    border-top-left-radius: 10px;
                    border-top-right-radius: 10px;
                    left: 0;
                }
            }
        }
    }
`;

export default SubNavigation;
