Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401FB74A919
	for <lists+linux-efi@lfdr.de>; Fri,  7 Jul 2023 04:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjGGCq3 (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 6 Jul 2023 22:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjGGCq2 (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 6 Jul 2023 22:46:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 766D619A5
        for <linux-efi@vger.kernel.org>; Thu,  6 Jul 2023 19:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688697940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qoH4ad0vFVh5H5bsCMA0Q+pNHJiT6f1IPBQfe5zvw5s=;
        b=Rf2cSmg+vOAd1nJc12S9Sl7Km0GBV40qujfvix6e2zyLp9rYsCc7/9GI92sQPVheC0bJSF
        W7Jd/jcPnAyWiaDC1/Gs+HZCa605ZMPMsTTrpyfjWA2zhvlt2vz74+NoPsluQQ1TTxzZZE
        AKTGJb9Sv4lZoxMe5oxzydrLvJi3bdE=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-99-6NPFoNixMW60lkBybvpoSw-1; Thu, 06 Jul 2023 22:45:34 -0400
X-MC-Unique: 6NPFoNixMW60lkBybvpoSw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0DED638149A8;
        Fri,  7 Jul 2023 02:45:34 +0000 (UTC)
Received: from darkstar.users.ipa.redhat.com (ovpn-12-250.pek2.redhat.com [10.72.12.250])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4C469C478DE;
        Fri,  7 Jul 2023 02:45:27 +0000 (UTC)
Date:   Fri, 7 Jul 2023 10:47:00 +0800
From:   Dave Young <dyoung@redhat.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tao Liu <ltao@redhat.com>, tglx@linutronix.de, mingo@redhat.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, linux-kernel@vger.kernel.org, bhe@redhat.com,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH v2] x86/kexec: Add EFI config table identity mapping for
 kexec kernel
Message-ID: <ZKd8pK7yQ31FWkIx@darkstar.users.ipa.redhat.com>
References: <20230601072043.24439-1-ltao@redhat.com>
 <20230705173359.GDZKWphyFbNE8id6Jm@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230705173359.GDZKWphyFbNE8id6Jm@fat_crate.local>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On 07/05/23 at 07:33pm, Borislav Petkov wrote:
> On Thu, Jun 01, 2023 at 03:20:44PM +0800, Tao Liu wrote:
> > A kexec kernel bootup hang is observed on Intel Atom cpu due to unmapped
> 
> s/cpu/CPU/g
> 
> > EFI config table.
> > 
> > Currently EFI system table is identity-mapped for the kexec kernel, but EFI
> > config table is not mapped explicitly:
> 
> Why does the EFI config table *need* to be mapped explicitly?
> 
> >     commit 6bbeb276b71f ("x86/kexec: Add the EFI system tables and ACPI
> >                           tables to the ident map")
> > 
> > Later in the following 2 commits, EFI config table will be accessed when
> > enabling sev at kernel startup.
> 
> What does SEV have to do with an Intel problem?

I'm also curious, let's cc the author of below mentioned commits.

> 
> > This may result in a page fault due to EFI
> > config table's unmapped address. Since the page fault occurs at an early
> > stage, it is unrecoverable and kernel hangs.
> > 
> >     commit ec1c66af3a30 ("x86/compressed/64: Detect/setup SEV/SME features
> >                           earlier during boot")
> >     commit c01fce9cef84 ("x86/compressed: Add SEV-SNP feature
> >                           detection/setup")
> > 
> > In addition, the issue doesn't appear on all systems, because the kexec
> > kernel uses Page Size Extension (PSE) for identity mapping. In most cases,
> > EFI config table can end up to be mapped into due to 1 GB page size.
> > However if nogbpages is set, or cpu doesn't support pdpe1gb feature
> > (e.g Intel Atom x6425RE cpu), EFI config table may not be mapped into
> > due to 2 MB page size, thus a page fault hang is more likely to happen.
> 
> This doesn't answer my question above.
> 
> > This patch will make sure the EFI config table is always mapped.
> 
> Avoid having "This patch" or "This commit" in the commit message. It is
> tautologically useless.
> 
> Also, do
> 
> $ git grep 'This patch' Documentation/process
> 
> for more details.
> 
> 
> > 
> > Signed-off-by: Tao Liu <ltao@redhat.com>
> > ---
> > Changes in v2:
> > - Rephrase the change log based on Baoquan's suggestion.
> > - Rename map_efi_sys_cfg_tab() to map_efi_tables().
> > - Link to v1: https://lore.kernel.org/kexec/20230525094914.23420-1-ltao@redhat.com/
> > ---
> >  arch/x86/kernel/machine_kexec_64.c | 35 ++++++++++++++++++++++++++----
> >  1 file changed, 31 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
> > index 1a3e2c05a8a5..664aefa6e896 100644
> > --- a/arch/x86/kernel/machine_kexec_64.c
> > +++ b/arch/x86/kernel/machine_kexec_64.c
> > @@ -28,6 +28,7 @@
> >  #include <asm/setup.h>
> >  #include <asm/set_memory.h>
> >  #include <asm/cpu.h>
> > +#include <asm/efi.h>
> >  
> >  #ifdef CONFIG_ACPI
> >  /*
> > @@ -86,10 +87,12 @@ const struct kexec_file_ops * const kexec_file_loaders[] = {
> >  #endif
> >  
> >  static int
> > -map_efi_systab(struct x86_mapping_info *info, pgd_t *level4p)
> > +map_efi_tables(struct x86_mapping_info *info, pgd_t *level4p)
> >  {
> >  #ifdef CONFIG_EFI
> >  	unsigned long mstart, mend;
> > +	void *kaddr;
> > +	int ret;
> >  
> >  	if (!efi_enabled(EFI_BOOT))
> >  		return 0;
> > @@ -105,6 +108,30 @@ map_efi_systab(struct x86_mapping_info *info, pgd_t *level4p)
> >  	if (!mstart)
> >  		return 0;
> >  
> > +	ret = kernel_ident_mapping_init(info, level4p, mstart, mend);
> > +	if (ret)
> > +		return ret;
> > +
> > +	kaddr = memremap(mstart, mend - mstart, MEMREMAP_WB);
> > +	if (!kaddr) {
> > +		pr_err("Could not map UEFI system table\n");
> > +		return -ENOMEM;
> > +	}
> > +
> > +	mstart = efi_config_table;
> 
> Yeah, about this, did you see efi_reuse_config() and the comment above
> it especially?
> 
> Or is it that the EFI in that box wants the config table mapped 1:1 and
> accesses it during boot/kexec?
> 
> In any case, this is all cloudy without a proper root cause.

efi_reuse_config is patching the SMBIOS table address in efi init path
durint kexec kernel bootup due to some nasty firmware behavior.

It seems the sev code is searching for table with EFI_CC_BLOB_GUID. In
theory it is safe as it will not access SMBIOS table here.  But for
safe purpose it would be better to test on AMD SEV guest, see if the
EFI_CC_BLOB table address is untouched after the 1st kernel booting.

> 
> Also, I'd like for Ard to have a look at this too.
> 
> Thx.
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
> 

