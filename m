Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 322A4624D0F
	for <lists+linux-efi@lfdr.de>; Thu, 10 Nov 2022 22:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbiKJVer (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 10 Nov 2022 16:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiKJVeq (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 10 Nov 2022 16:34:46 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE73186CA;
        Thu, 10 Nov 2022 13:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668116084; x=1699652084;
  h=date:from:to:cc:subject:message-id:mime-version:
   content-transfer-encoding;
  bh=aNUQvPldLT7UDcSnLyns2My1ZQw1aBleYnzEk9P0fh0=;
  b=ZYdrQoah9L69YyPZmSGk54musbFCkyJwGsZ+4J+qN7ai7hUzH52eCK/U
   5XIkDgb/A2MZTH+jM8j3ZUUb/o0yIpPrwf3pEIlrbhDTtV9kgfDLJ6box
   6h54QY/xaHdyCmYzhRsv89l+NGh7oiAWycF9bp5pTQy89ETcwHjpZoXcf
   0ClA3rf0FCVbl5C6Q41zvjDpxuvsAAwnrXVxvTVqPqkDboW4h2UMou6al
   pkejz/TkgrlTXWPoW+STMlay5QEXPNNLs/NhGsEZnwUxRf23rSXg9FJEX
   m5Xby6h0j6arjuQMLHZJ6iFllUDH1m7tc34oekf4s1XurJ1AfwZ0FVeyj
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="313228768"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="313228768"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 13:34:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="779942138"
X-IronPort-AV: E=Sophos;i="5.96,154,1665471600"; 
   d="scan'208";a="779942138"
Received: from lkp-server01.sh.intel.com (HELO e783503266e8) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 10 Nov 2022 13:34:40 -0800
Received: from kbuild by e783503266e8 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1otFC3-0003Gd-2O;
        Thu, 10 Nov 2022 21:34:39 +0000
Date:   Fri, 11 Nov 2022 05:34:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     nouveau@lists.freedesktop.org, netfilter-devel@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-media@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, coreteam@netfilter.org,
        amd-gfx@lists.freedesktop.org,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [linux-next:master] BUILD REGRESSION
 382d2f9e739bc6f151c718b38537ae522ff848cd
Message-ID: <636d6e67.HpQqom77xkNYoUGy%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: 382d2f9e739bc6f151c718b38537ae522ff848cd  Add linux-next specific files for 20221110

Error/Warning reports:

https://lore.kernel.org/linux-mm/202210261404.b6UlzG7H-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202210270637.Q5Y7FiKJ-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202211030513.ML6SdpUw-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202211052104.11idvQu3-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202211090634.RyFKK0WS-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202211102047.QP7IThm4-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202211102136.g5R1ioFx-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202211110007.0ZmHwzMd-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202211110149.0ETIfpy6-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

arch/arm/mach-s3c/devs.c:32:10: fatal error: linux/platform_data/dma-s3c24xx.h: No such file or directory
arch/x86/platform/efi/runtime-map.c:138:5: warning: no previous prototype for 'efi_get_runtime_map_size' [-Wmissing-prototypes]
arch/x86/platform/efi/runtime-map.c:143:5: warning: no previous prototype for 'efi_get_runtime_map_desc_size' [-Wmissing-prototypes]
arch/x86/platform/efi/runtime-map.c:148:5: warning: no previous prototype for 'efi_runtime_map_copy' [-Wmissing-prototypes]
drivers/firmware/efi/memmap.c:57:52: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
drivers/firmware/efi/memmap.c:60:52: warning: suggest braces around empty body in an 'if' statement [-Wempty-body]
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc.c:4887: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:5073:24: warning: implicit conversion from 'enum <anonymous>' to 'enum dc_status' [-Wenum-conversion]
drivers/gpu/drm/nouveau/nvkm/engine/fifo/gf100.c:178:1: warning: no previous prototype for 'gf100_fifo_nonstall_block' [-Wmissing-prototypes]
drivers/gpu/drm/nouveau/nvkm/engine/fifo/gf100.c:178:1: warning: no previous prototype for function 'gf100_fifo_nonstall_block' [-Wmissing-prototypes]
drivers/gpu/drm/nouveau/nvkm/engine/fifo/gf100.c:451:1: warning: no previous prototype for 'gf100_fifo_nonstall_block' [-Wmissing-prototypes]
drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c:1474:38: warning: unused variable 'mt8173_jpeg_drvdata' [-Wunused-const-variable]
drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c:1489:38: warning: unused variable 'mtk_jpeg_drvdata' [-Wunused-const-variable]
drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c:1859:38: warning: unused variable 'mtk8195_jpegdec_drvdata' [-Wunused-const-variable]
vmlinux.o: warning: objtool: __btrfs_map_block+0x1e22: unreachable instruction

Unverified Error/Warning (likely false positive, please contact us if interested):

lib/zstd/compress/../common/zstd_deps.h:34:28: warning: use of NULL '*zc.outBuff' where non-null expected [CWE-476] [-Wanalyzer-null-argument]
lib/zstd/compress/huf_compress.c:460 HUF_getIndex() warn: the 'RANK_POSITION_LOG_BUCKETS_BEGIN' macro might need parens
lib/zstd/compress/huf_compress.c:850:18: warning: shift by count ('32') >= precision of type ('32') [-Wanalyzer-shift-count-overflow]
lib/zstd/decompress/zstd_decompress_block.c:1009 ZSTD_execSequence() warn: inconsistent indenting
lib/zstd/decompress/zstd_decompress_block.c:894 ZSTD_execSequenceEnd() warn: inconsistent indenting
lib/zstd/decompress/zstd_decompress_block.c:942 ZSTD_execSequenceEndSplitLitBuffer() warn: inconsistent indenting
lib/zstd/decompress/zstd_decompress_internal.h:206 ZSTD_DCtx_get_bmi2() warn: inconsistent indenting
mm/khugepaged.c:2038 collapse_file() warn: iterator used outside loop: 'page'

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- alpha-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_link_dp.c:warning:implicit-conversion-from-enum-anonymous-to-enum-dc_status
|   `-- drivers-gpu-drm-nouveau-nvkm-engine-fifo-gf100.c:warning:no-previous-prototype-for-gf100_fifo_nonstall_block
|-- alpha-buildonly-randconfig-r005-20221110
|   `-- drivers-gpu-drm-nouveau-nvkm-engine-fifo-gf100.c:warning:no-previous-prototype-for-gf100_fifo_nonstall_block
|-- arc-allyesconfig
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_link_dp.c:warning:implicit-conversion-from-enum-anonymous-to-enum-dc_status
|   `-- drivers-gpu-drm-nouveau-nvkm-engine-fifo-gf100.c:warning:no-previous-prototype-for-gf100_fifo_nonstall_block
|-- arm-allyesconfig
|   |-- arch-arm-mach-s3c-devs.c:fatal-error:linux-platform_data-dma-s3c24xx.h:No-such-file-or-directory
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_link_dp.c:warning:implicit-conversion-from-enum-anonymous-to-enum-dc_status
|-- arm-randconfig-m031-20221109
|   |-- lib-zstd-compress-huf_compress.c-HUF_getIndex()-warn:the-RANK_POSITION_LOG_BUCKETS_BEGIN-macro-might-need-parens
|   |-- lib-zstd-decompress-zstd_decompress_block.c-ZSTD_execSequence()-warn:inconsistent-indenting
|   |-- lib-zstd-decompress-zstd_decompress_block.c-ZSTD_execSequenceEnd()-warn:inconsistent-indenting
|   |-- lib-zstd-decompress-zstd_decompress_block.c-ZSTD_execSequenceEndSplitLitBuffer()-warn:inconsistent-indenting
|   `-- lib-zstd-decompress-zstd_decompress_internal.h-ZSTD_DCtx_get_bmi2()-warn:inconsistent-indenting
|-- arm64-allyesconfig
|   |-- drivers-firmware-efi-memmap.c:warning:suggest-braces-around-empty-body-in-an-if-statement
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_link_dp.c:warning:implicit-conversion-from-enum-anonymous-to-enum-dc_status
|-- arm64-randconfig-s042-20221110
|   |-- drivers-firmware-efi-memmap.c:warning:suggest-braces-around-empty-body-in-an-if-statement
|   `-- drivers-firmware-raspberrypi.c:sparse:sparse:incorrect-type-in-initializer-(different-base-types)-expected-restricted-__le32-usertype-id-got-unsigned-int-id
|-- csky-randconfig-p001-20221110
|   `-- drivers-gpu-drm-nouveau-nvkm-engine-fifo-gf100.c:warning:no-previous-prototype-for-gf100_fifo_nonstall_block
|-- i386-allyesconfig
|   |-- arch-x86-platform-efi-runtime-map.c:warning:no-previous-prototype-for-efi_get_runtime_map_desc_size
|   |-- arch-x86-platform-efi-runtime-map.c:warning:no-previous-prototype-for-efi_get_runtime_map_size
|   |-- arch-x86-platform-efi-runtime-map.c:warning:no-previous-prototype-for-efi_runtime_map_copy
|   |-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc.c:warning:This-comment-starts-with-but-isn-t-a-kernel-doc-comment.-Refer-Documentation-doc-guide-kernel-doc.rst
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_link_dp.c:warning:implicit-conversion-from-enum-anonymous-to-enum-dc_status
|-- i386-randconfig-c001
|   |-- lib-zstd-compress-..-common-zstd_deps.h:warning:use-of-NULL-zc.outBuff-where-non-null-expected-CWE
|   `-- lib-zstd-compress-huf_compress.c:warning:shift-by-count-(-)-precision-of-type-(-)
|-- i386-randconfig-m021
|   |-- arch-x86-boot-compressed-..-..-..-..-lib-zstd-decompress-zstd_decompress_block.c-ZSTD_execSequence()-warn:inconsistent-indenting
|   |-- arch-x86-boot-compressed-..-..-..-..-lib-zstd-decompress-zstd_decompress_block.c-ZSTD_execSequenceEnd()-warn:inconsistent-indenting
|   |-- arch-x86-boot-compressed-..-..-..-..-lib-zstd-decompress-zstd_decompress_block.c-ZSTD_execSequenceEndSplitLitBuffer()-warn:inconsistent-indenting
|   |-- arch-x86-boot-compressed-..-..-..-..-lib-zstd-decompress-zstd_decompress_internal.h-ZSTD_DCtx_get_bmi2()-warn:inconsistent-indenting
|   |-- lib-zstd-compress-huf_compress.c-HUF_getIndex()-warn:the-RANK_POSITION_LOG_BUCKETS_BEGIN-macro-might-need-parens
|   |-- lib-zstd-decompress-zstd_decompress_block.c-ZSTD_execSequence()-warn:inconsistent-indenting
|   |-- lib-zstd-decompress-zstd_decompress_block.c-ZSTD_execSequenceEnd()-warn:inconsistent-indenting
|   |-- lib-zstd-decompress-zstd_decompress_block.c-ZSTD_execSequenceEndSplitLitBuffer()-warn:inconsistent-indenting
|   |-- lib-zstd-decompress-zstd_decompress_internal.h-ZSTD_DCtx_get_bmi2()-warn:inconsistent-indenting
|   `-- mm-khugepaged.c-collapse_file()-warn:iterator-used-outside-loop:page
|-- ia64-allmodconfig
|   |-- drivers-firmware-efi-memmap.c:warning:suggest-braces-around-empty-body-in-an-if-statement
|   `-- drivers-gpu-drm-amd-amdgpu-..-display-dc-core-dc_link_dp.c:warning:implicit-conversion-from-enum-anonymous-to-enum-dc_status
|-- ia64-randconfig-c031-20221110
clang_recent_errors
|-- hexagon-randconfig-r045-20221110
|   |-- drivers-media-platform-mediatek-jpeg-mtk_jpeg_core.c:warning:unused-variable-mt8173_jpeg_drvdata
|   |-- drivers-media-platform-mediatek-jpeg-mtk_jpeg_core.c:warning:unused-variable-mtk8195_jpegdec_drvdata
|   `-- drivers-media-platform-mediatek-jpeg-mtk_jpeg_core.c:warning:unused-variable-mtk_jpeg_drvdata
|-- hexagon-randconfig-r045-20221111
|   |-- drivers-media-platform-mediatek-jpeg-mtk_jpeg_core.c:warning:unused-variable-mt8173_jpeg_drvdata
|   `-- drivers-media-platform-mediatek-jpeg-mtk_jpeg_core.c:warning:unused-variable-mtk_jpeg_drvdata
`-- s390-randconfig-r022-20221110
    `-- drivers-gpu-drm-nouveau-nvkm-engine-fifo-gf100.c:warning:no-previous-prototype-for-function-gf100_fifo_nonstall_block

elapsed time: 736m

configs tested: 77
configs skipped: 2

gcc tested configs:
arm                            xcep_defconfig
openrisc                         alldefconfig
arm                               allnoconfig
sh                        apsh4ad0a_defconfig
powerpc                    adder875_defconfig
powerpc                      arches_defconfig
i386                             alldefconfig
sh                          lboxre2_defconfig
m68k                        mvme16x_defconfig
sh                        edosk7760_defconfig
powerpc                       holly_defconfig
arm                             pxa_defconfig
sh                         ap325rxa_defconfig
sh                        sh7763rdp_defconfig
um                             i386_defconfig
um                           x86_64_defconfig
arm                            pleb_defconfig
x86_64                            allnoconfig
powerpc                      bamboo_defconfig
x86_64                              defconfig
i386                          randconfig-a014
x86_64                           rhel-8.3-kvm
x86_64                           rhel-8.3-syz
i386                          randconfig-a012
arm                       imx_v6_v7_defconfig
i386                                defconfig
i386                          randconfig-a016
ia64                             allmodconfig
m68k                             allyesconfig
arm                                 defconfig
x86_64                         rhel-8.3-kunit
powerpc                     tqm8541_defconfig
x86_64                          rhel-8.3-func
x86_64                               rhel-8.3
arc                                 defconfig
x86_64                        randconfig-a002
x86_64                    rhel-8.3-kselftests
riscv                          rv32_defconfig
i386                             allyesconfig
s390                             allmodconfig
x86_64                           allyesconfig
arm                              allyesconfig
alpha                               defconfig
i386                          randconfig-a001
arc                  randconfig-r043-20221110
x86_64                        randconfig-a004
i386                          randconfig-a003
s390                                defconfig
x86_64                        randconfig-a006
i386                          randconfig-a005
powerpc                           allnoconfig
arm64                            allyesconfig
i386                          randconfig-c001
s390                             allyesconfig
sh                               allmodconfig
m68k                             allmodconfig
alpha                            allyesconfig
arc                              allyesconfig
mips                             allyesconfig
powerpc                          allmodconfig

clang tested configs:
powerpc                    ge_imp3a_defconfig
powerpc                     ppa8548_defconfig
mips                        omega2p_defconfig
powerpc                     kilauea_defconfig
i386                          randconfig-a013
i386                          randconfig-a011
i386                          randconfig-a015
powerpc                  mpc866_ads_defconfig
x86_64                        randconfig-a001
x86_64                        randconfig-a003
hexagon              randconfig-r041-20221110
riscv                randconfig-r042-20221110
x86_64                        randconfig-a005
i386                          randconfig-a002
hexagon              randconfig-r045-20221110
i386                          randconfig-a004
s390                 randconfig-r044-20221110

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
