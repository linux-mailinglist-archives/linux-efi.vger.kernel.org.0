Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFF8E687F76
	for <lists+linux-efi@lfdr.de>; Thu,  2 Feb 2023 15:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbjBBOA2 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 2 Feb 2023 09:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbjBBOAZ (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 2 Feb 2023 09:00:25 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3E68F24C
        for <linux-efi@vger.kernel.org>; Thu,  2 Feb 2023 06:00:15 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id q10so1796977wrm.4
        for <linux-efi@vger.kernel.org>; Thu, 02 Feb 2023 06:00:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eMycSpSWqkLdJLuPU1kAliRBYKe3vnTJI8phLtEWdDI=;
        b=aX1rwy2YkRI6JACyuVKP5etYUZPG7JUA1R0As0ErGFAkMlpt62aDBJPcsvUThjjLom
         aHdlUs0Y6cY8dMz8yVgjfbpxGSITYHw/tENe8vYZTa+C3VCETc9gVSndANh7BGPRucVP
         R0tKqZXPEBxJK7CU1Jh9mDaIMl2DIWJbDIMxIO+/uu35JSJIVJD1vWZOt1mmc88NiiR8
         0uJvVQMHzoOz3hCH1BMHW6gHyKotDAAsfCIhxpAyANFwjLQYuQ8JhLBmZX6MsjH+pc2S
         9Z3ShGePx1zGree3SOmONdQ8tYPk7U1WvD59xKqM+rfje4EhiK03hKx4EFr7ihC5IVvW
         ZjHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eMycSpSWqkLdJLuPU1kAliRBYKe3vnTJI8phLtEWdDI=;
        b=Z6gTziZOQn5896kQ1w3u/fprfIqlGtNWEURinUCp8IuFdrz/akBc+KN7UF1WfMEUNb
         N1g94B0MW8BiJPLrIr6hF22tj/540RXedRS+0g/aYK2FwTb/9iI9BUdKiwfscI2i4i6x
         4FVMNhkLeP+AB9LkraET4D847hWF0B+fqpkGvJ/IPy7qRP94HRcoBOpYTPK7aCMdDgEA
         VOxGZd68ryD2YaQzWcO3tqxhCiRb7CEGnPKBngpGgI5oRD/3AsSAGEBwO5WxpM++9dxy
         sUJV72H3y9rlDlK91T49bD5zUKLgXURxWC5XIeHdFbqgnOibaiw16GK9EQa0MG6pqAaI
         KjGg==
X-Gm-Message-State: AO0yUKXEwhc2z8m+837V0KgcSnUPtJUFmNJJxtYZv2LTSAGcpBPlTVah
        86uMaOEdE0ih5O3Thl6hb3N7a3pAeTZSRKixRQsrzw==
X-Google-Smtp-Source: AK7set991hy80LggrGKuE0EGDn0gAr/4aLuvD+To3+bf8l/YlM8w4oAxF3edTa+/NMUuSWyoDpk+UbMMdtjLXw/6knk=
X-Received: by 2002:adf:ffcb:0:b0:2bf:e95c:9918 with SMTP id
 x11-20020adfffcb000000b002bfe95c9918mr211434wrs.330.1675346413910; Thu, 02
 Feb 2023 06:00:13 -0800 (PST)
MIME-Version: 1.0
References: <20230125082333.1577572-3-alexghiti@rivosinc.com> <202302010819.RAsjyv6V-lkp@intel.com>
In-Reply-To: <202302010819.RAsjyv6V-lkp@intel.com>
From:   Alexandre Ghiti <alexghiti@rivosinc.com>
Date:   Thu, 2 Feb 2023 15:00:02 +0100
Message-ID: <CAHVXubht443DmB6qZMJ=Hyxz=xi65Dkd=PuN_2i=uf783z0B=Q@mail.gmail.com>
Subject: Re: [PATCH v3 2/6] riscv: Rework kasan population functions
To:     kernel test robot <lkp@intel.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Conor Dooley <conor@kernel.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-efi@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Feb 1, 2023 at 1:16 AM kernel test robot <lkp@intel.com> wrote:
>
> Hi Alexandre,
>
> Thank you for the patch! Perhaps something to improve:
>
> [auto build test WARNING on linus/master]
> [also build test WARNING on v6.2-rc6 next-20230131]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Alexandre-Ghiti/riscv-Split-early-and-final-KASAN-population-functions/20230125-163113
> patch link:    https://lore.kernel.org/r/20230125082333.1577572-3-alexghiti%40rivosinc.com
> patch subject: [PATCH v3 2/6] riscv: Rework kasan population functions
> config: riscv-randconfig-r006-20230201 (https://download.01.org/0day-ci/archive/20230201/202302010819.RAsjyv6V-lkp@intel.com/config)
> compiler: riscv64-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/c18726e8d14edbd59ec19854b4eb06d83fff716f
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Alexandre-Ghiti/riscv-Split-early-and-final-KASAN-population-functions/20230125-163113
>         git checkout c18726e8d14edbd59ec19854b4eb06d83fff716f
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv olddefconfig
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash arch/riscv/mm/
>
> If you fix the issue, kindly add following tag where applicable
> | Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
> >> arch/riscv/mm/kasan_init.c:442:6: warning: no previous prototype for 'create_tmp_mapping' [-Wmissing-prototypes]
>      442 | void create_tmp_mapping(void)
>          |      ^~~~~~~~~~~~~~~~~~
>
>
> vim +/create_tmp_mapping +442 arch/riscv/mm/kasan_init.c
>
>    441
>  > 442  void create_tmp_mapping(void)
>    443  {
>    444          void *ptr;
>    445          p4d_t *base_p4d;
>    446
>    447          /*
>    448           * We need to clean the early mapping: this is hard to achieve "in-place",
>    449           * so install a temporary mapping like arm64 and x86 do.
>    450           */
>    451          memcpy(tmp_pg_dir, swapper_pg_dir, sizeof(pgd_t) * PTRS_PER_PGD);
>    452
>    453          /* Copy the last p4d since it is shared with the kernel mapping. */
>    454          if (pgtable_l5_enabled) {
>    455                  ptr = (p4d_t *)pgd_page_vaddr(*pgd_offset_k(KASAN_SHADOW_END));
>    456                  memcpy(tmp_p4d, ptr, sizeof(p4d_t) * PTRS_PER_P4D);
>    457                  set_pgd(&tmp_pg_dir[pgd_index(KASAN_SHADOW_END)],
>    458                          pfn_pgd(PFN_DOWN(__pa(tmp_p4d)), PAGE_TABLE));
>    459                  base_p4d = tmp_p4d;
>    460          } else {
>    461                  base_p4d = (p4d_t *)tmp_pg_dir;
>    462          }
>    463
>    464          /* Copy the last pud since it is shared with the kernel mapping. */
>    465          if (pgtable_l4_enabled) {
>    466                  ptr = (pud_t *)p4d_page_vaddr(*(base_p4d + p4d_index(KASAN_SHADOW_END)));
>    467                  memcpy(tmp_pud, ptr, sizeof(pud_t) * PTRS_PER_PUD);
>    468                  set_p4d(&base_p4d[p4d_index(KASAN_SHADOW_END)],
>    469                          pfn_p4d(PFN_DOWN(__pa(tmp_pud)), PAGE_TABLE));
>    470          }
>    471  }
>    472

Ok, I have to declare this function static to quiet this warning,
there will be a v4 soon then.

>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests
