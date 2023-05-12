Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFE2B700C28
	for <lists+linux-efi@lfdr.de>; Fri, 12 May 2023 17:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242000AbjELPoM (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 12 May 2023 11:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241173AbjELPoL (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 12 May 2023 11:44:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E9D40CD;
        Fri, 12 May 2023 08:44:09 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1683906241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lTa5g+pxhC6EjhK4uNcZKNdGUeakcPfkaE7Sp7t1J14=;
        b=UaD8yoj2U9lr8h5H0rsMBsGYlyNn2hxAb941Mp3TFiNn4oZChtd05Xt6nJk8TlbOurDzTN
        jrAuHIBnB9J9bFDYdYtRHCd4yIT31SUVWFzFUgheDKOUilAglOUDCbs2MDpTEPZu2O/c5e
        L+wqK55Tje6TjpAQd8Za5E7tRjsXoaF41wKIjkmCt1ZRtr/t2reIN1HK0Y4C4WVoegpm5i
        JoJC0DrQ+FONd8+MIjvBDaQOsCNZpto7t8GoARW3Cox6eijL4aEd0En7ax+lE4OOJ/9cUh
        tsPpzuqxVshaHg2qDwn6VH/mboWoOHnAy98soXWmm/7uzNEB52VTAmouOdTVzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1683906241;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=lTa5g+pxhC6EjhK4uNcZKNdGUeakcPfkaE7Sp7t1J14=;
        b=EOKuudnx/6QNvHJfaDUG8EOeYSN7duIrAZ/X1CRE8aCeryg1rVmoUnOcaaOLbimGKkJA64
        82SKWrbbMUlGACDg==
To:     Ross Philipson <ross.philipson@oracle.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org
Cc:     ross.philipson@oracle.com, dpsmith@apertussolutions.com,
        mingo@redhat.com, bp@alien8.de, hpa@zytor.com, ardb@kernel.org,
        mjg59@srcf.ucam.org, James.Bottomley@hansenpartnership.com,
        luto@amacapital.net, nivedita@alum.mit.edu,
        kanth.ghatraju@oracle.com, trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v6 08/14] x86: Secure Launch kernel late boot stub
In-Reply-To: <20230504145023.835096-9-ross.philipson@oracle.com>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-9-ross.philipson@oracle.com>
Date:   Fri, 12 May 2023 17:44:00 +0200
Message-ID: <87jzxdblmn.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, May 04 2023 at 14:50, Ross Philipson wrote:
> The routine slaunch_setup is called out of the x86 specific setup_arch

Can you please make functions visible in changelogs by appending (),
i.e. setup_arch() ?

See https://www.kernel.org/doc/html/latest/process/maintainer-tip.html
for further hints.

> +static u32 sl_flags;
> +static struct sl_ap_wake_info ap_wake_info;
> +static u64 evtlog_addr;
> +static u32 evtlog_size;
> +static u64 vtd_pmr_lo_size;

Is any of this modifyable after boot? If not then this wants to be
annotated with __ro_after_init.

> +/* This should be plenty of room */
> +static u8 txt_dmar[PAGE_SIZE] __aligned(16);
> +
> +u32 slaunch_get_flags(void)
> +{
> +	return sl_flags;
> +}
> +EXPORT_SYMBOL(slaunch_get_flags);

What needs this export? If there is a reason then please EXPORT_SYMBOL_GPL()

> +struct sl_ap_wake_info *slaunch_get_ap_wake_info(void)
> +{
> +	return &ap_wake_info;
> +}

If you return a pointer, then there is not much of point for encapsulating.

> +struct acpi_table_header *slaunch_get_dmar_table(struct acpi_table_header *dmar)

Some explanation on public visible functions would be really useful.

> +{
> +	/* The DMAR is only stashed and provided via TXT on Intel systems */

-ENOPARSE.

> +	if (memcmp(txt_dmar, "DMAR", 4))
> +		return dmar;
> +
> +	return (struct acpi_table_header *)(&txt_dmar[0]);

s/&txt_dmar[0]/txt_dmar/ No?

> +}

> +void __noreturn slaunch_txt_reset(void __iomem *txt,
> +				  const char *msg, u64 error)

Please avoid these line breaks. We lifted the 80 character limit quite
some time ago.

> +
> +	/* Iterate over heap tables looking for table of "type" */
> +	for (i = 0; i < type; i++) {
> +		base += offset;
> +		heap = early_memremap(base, sizeof(u64));
> +		if (!heap)
> +			slaunch_txt_reset(txt,
> +				"Error early_memremap of heap for heap walk\n",
> +				SL_ERROR_HEAP_MAP);

This is horrible to read.

		if (!heap) {
			slaunch_txt_reset(txt, "Error early_memremap of heap for heap walk\n",
                        		  SL_ERROR_HEAP_MAP);
                }

See documentation about bracket rules.

> +
> +/*
> + * TXT stashes a safe copy of the DMAR ACPI table to prevent tampering.
> + * It is stored in the TXT heap. Fetch it from there and make it available
> + * to the IOMMU driver.
> + */
> +static void __init slaunch_copy_dmar_table(void __iomem *txt)
> +{
> +	struct txt_sinit_mle_data *sinit_mle_data;
> +	u32 field_offset, dmar_size, dmar_offset;
> +	void *dmar;
> +
> +	memset(&txt_dmar, 0, PAGE_SIZE);

txt_dmar is statically allocated so it's already zero, no?

> +/*
> + * Intel TXT specific late stub setup and validation.
> + */
> +void __init slaunch_setup_txt(void)
> +{
> +	u64 one = TXT_REGVALUE_ONE, val;
> +	void __iomem *txt;
> +
> +	if (!boot_cpu_has(X86_FEATURE_SMX))
> +		return;
> +
> +	/*
> +	 * If booted through secure launch entry point, the loadflags
> +	 * option will be set.
> +	 */
> +	if (!(boot_params.hdr.loadflags & SLAUNCH_FLAG))
> +		return;
> +
> +	/*
> +	 * See if SENTER was done by reading the status register in the
> +	 * public space. If the public register space cannot be read, TXT may
> +	 * be disabled.
> +	 */
> +	txt = early_ioremap(TXT_PUB_CONFIG_REGS_BASE,
> +			    TXT_NR_CONFIG_PAGES * PAGE_SIZE);
> +	if (!txt)
> +		return;

Wait. You have established above that SMX is available and the boot has
set the SLAUNCH flag.

So if that ioremap() fails then there is an issue with the fixmaps.

How is returning here sensible? The system will just die later on in the
worst case with some undecodable issue.

Thanks,

        tglx
