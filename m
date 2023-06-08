Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A60937284A1
	for <lists+linux-efi@lfdr.de>; Thu,  8 Jun 2023 18:10:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233027AbjFHQKZ (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 8 Jun 2023 12:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbjFHQKX (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 8 Jun 2023 12:10:23 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A2F1FDF;
        Thu,  8 Jun 2023 09:10:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686240622; x=1717776622;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6pjyKOoy7arAWPVn5V85eq2ZYV5aLec/VZcsAEX55EQ=;
  b=E7GSQKukzRQSc0VAfT3HLLEMufdEcHsc8GLKjty0OYayld4Fjp4BHRgg
   QWmtdRTlkYcIiIn6ZdObgsoyfrJPXM3Rn5UX+06aHJTZ+G8tC5B7Y7XbP
   VkPwV/zcng++y6xTQQaxhRPxZkhOhi3jMQFn1zPPoRhffnIZyeTnHmcss
   6CMzdJ7vZVggYo0/18aDcvg6kwZS0578tFS/sEc6kLIs+llnytxY+5zeh
   uvfAyYllHwnvcZsKo7yUaiMlP2zuK/wLiU3DPgYD93Rg4qUL3qqLxWXt7
   uOkrx2nOlklzYgXLN9CRLSedQrXs9B0YJjqikELHHJpWFW+xsLrjBi/lx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="336986136"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="336986136"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 09:10:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="884249892"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="884249892"
Received: from yjiang5-mobl.amr.corp.intel.com (HELO localhost) ([10.144.161.97])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 09:10:22 -0700
Date:   Thu, 8 Jun 2023 09:10:20 -0700
From:   Yunhong Jiang <yunhong.jiang@linux.intel.com>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Evgeniy Baskov <baskov@ispras.ru>,
        Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexey Khoroshilov <khoroshilov@ispras.ru>,
        Peter Jones <pjones@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Kees Cook <keescook@chromium.org>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joerg Roedel <jroedel@suse.de>
Subject: Re: [PATCH v5 13/20] x86/efistub: Perform 4/5 level paging switch
 from the stub
Message-ID: <20230608161020.GA69@yjiang5-mobl.amr.corp.intel.com>
References: <20230607072342.4054036-1-ardb@kernel.org>
 <20230607072342.4054036-14-ardb@kernel.org>
 <20230607201924.GD3110@yjiang5-mobl.amr.corp.intel.com>
 <CAMj1kXE7nW6ED1CmCd-by5HC7oqFAZd4=-ky_Kx_g6Br28PNhQ@mail.gmail.com>
 <20230608004342.GA4340@yjiang5-mobl.amr.corp.intel.com>
 <CAMj1kXHCAnNDFt+Ksex24PJj_rx5GcUsiS=S3OSZ6dw1HNOH3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXHCAnNDFt+Ksex24PJj_rx5GcUsiS=S3OSZ6dw1HNOH3w@mail.gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, Jun 08, 2023 at 08:34:38AM +0200, Ard Biesheuvel wrote:
> On Thu, 8 Jun 2023 at 02:43, Yunhong Jiang
> <yunhong.jiang@linux.intel.com> wrote:
> >
> > On Wed, Jun 07, 2023 at 10:31:43PM +0200, Ard Biesheuvel wrote:
> > > On Wed, 7 Jun 2023 at 22:19, Yunhong Jiang
> > > <yunhong.jiang@linux.intel.com> wrote:
> > > >
> > > > On Wed, Jun 07, 2023 at 09:23:35AM +0200, Ard Biesheuvel wrote:
> ...
> > > > > +efi_status_t efi_setup_5level_paging(void)
> > > > > +{
> > > > > +     u8 tmpl_size = (u8 *)&trampoline_ljmp_imm_offset - (u8 *)&trampoline_32bit_src;
> > > > > +     efi_status_t status;
> > > > > +     u8 *la57_code;
> > > > > +
> > > > > +     if (!efi_is_64bit())
> > > > > +             return EFI_SUCCESS;
> > > > > +
> > > > > +     /* check for 5 level paging support */
> > > > > +     if (native_cpuid_eax(0) < 7 ||
> > > > > +         !(native_cpuid_ecx(7) & (1 << (X86_FEATURE_LA57 & 31))))
> > > > > +             return EFI_SUCCESS;
> > > > > +
> > > > Do we need to check the need_toggle here instead of at efi_5level_switch and
> > > > skip the whole setup if no need to switch the paging level? Sorry if I missed
> > > > any point.
> > > >
> > >
> > > No. There are reasons why firmware might run with 5 levels, and switch
> > > to 4 levels at ExitBootServices() time.
> >
> > The need_toggle check at efi_5level_switch(), "need_toggle = want_la57 ^
> > have_la57", should cover this scenario, right? If we check need_toggle on
> > efi_setup_5level_paging() and it's false, then we don't need the setup in
> > efi_setup_5level_paging(), right? I don't see the  la57_toggle() called on other
> > places.
> >
> > Or I misunderstand your response?
> >
> 
> The actual, current number of paging levels could be 5 during
> efi_setup_5level_paging() and 4 during efi_5level_switch(). So whether
> we need to toggle can only be decided at switch time, at which point
> we can no longer allocate memory. So the allocation logic in
> efi_setup_5level_paging() cannot depend on the actual number of
> levels, only on whether or not 5 level paging is supported at all (in
> which case a switch is never needed)

Oh, I didn't realize that. Thank you for the clarification.
