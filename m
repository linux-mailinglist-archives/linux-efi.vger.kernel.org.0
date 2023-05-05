Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6262D6F86A5
	for <lists+linux-efi@lfdr.de>; Fri,  5 May 2023 18:25:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbjEEQZt (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Fri, 5 May 2023 12:25:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjEEQZs (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Fri, 5 May 2023 12:25:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAC11814D;
        Fri,  5 May 2023 09:25:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76D3C6145A;
        Fri,  5 May 2023 16:25:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F24A9C433D2;
        Fri,  5 May 2023 16:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683303946;
        bh=AjJF3rznt+Ti0zY3wvgVsm1uKpnaub6aIix98B10Tbw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DbiEUDJyS/8oeUjt2ksucAdHtRETadxXkeKVgHi1ZHc3e+obt9baz3rtLxN3lAYn1
         Kz/s9IJ3kevctsUtTrPYYSmpTGH3eUMTPbNo++i0UQ4RG69kl2bzUHFf0bJMA3v0Vq
         LR6203a7aLRIv7Dhqhvo5z8zKC4WecZ0o+1a1FcHWjSA/3gcGaLcMeep5nv2Fi3lrW
         L1Me5AJHeKkWshm28Jmh5LSOnn+EaKV5inwyw/mIzUs40jfIZhTEjtHdqejbjPqPSp
         Kbwxns5VZlfk+eevOByvwfnJx6QCGcV+GkI+CySwTUfD7Bknu/HYk1RHiB2bW7IRjg
         uq2ETteiSmGUg==
Date:   Fri, 5 May 2023 18:25:40 +0200
From:   Simon Horman <horms@kernel.org>
To:     Ross Philipson <ross.philipson@oracle.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org,
        kexec@lists.infradead.org, linux-efi@vger.kernel.org,
        dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, ardb@kernel.org, mjg59@srcf.ucam.org,
        James.Bottomley@hansenpartnership.com, luto@amacapital.net,
        nivedita@alum.mit.edu, kanth.ghatraju@oracle.com,
        trenchboot-devel@googlegroups.com
Subject: Re: [PATCH v6 05/14] x86: Secure Launch main header file
Message-ID: <ZFUuBIh4wSnXwBnz@kernel.org>
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-6-ross.philipson@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504145023.835096-6-ross.philipson@oracle.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, May 04, 2023 at 02:50:14PM +0000, Ross Philipson wrote:
> Introduce the main Secure Launch header file used in the early SL stub
> and the early setup code.
> 
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>  include/linux/slaunch.h | 513 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 513 insertions(+)
>  create mode 100644 include/linux/slaunch.h
> 
> diff --git a/include/linux/slaunch.h b/include/linux/slaunch.h

...

> +/* TXTCR_STS status bits */
> +#define TXT_SENTER_DONE_STS		(1<<0)
> +#define TXT_SEXIT_DONE_STS		(1<<1)

nit: Please consider using BIT()

...

> +/*
> + * External functions avalailable in mainline kernel.
> + */
> +extern void slaunch_setup_txt(void);
> +extern u32 slaunch_get_flags(void);
> +extern struct sl_ap_wake_info *slaunch_get_ap_wake_info(void);
> +extern struct acpi_table_header *slaunch_get_dmar_table(struct acpi_table_header *dmar);
> +extern void __noreturn slaunch_txt_reset(void __iomem *txt,
> +					 const char *msg, u64 error);
> +extern void slaunch_finalize(int do_sexit);

I think that extern should be avoided.
Perhaps these are in a header file that can be included?

> +
> +#endif /* !__ASSEMBLY */
> +
> +#else
> +
> +#define slaunch_setup_txt()		do { } while (0)
> +#define slaunch_get_flags()		0
> +#define slaunch_get_dmar_table(d)	(d)
> +#define slaunch_finalize(d)		do { } while (0)

I think it is usual to use static functions for this purpose.
Usually they end up in header files as static inline functions.

> +
> +#endif /* !IS_ENABLED(CONFIG_SECURE_LAUNCH) */
> +
> +#endif /* _LINUX_SLAUNCH_H */
