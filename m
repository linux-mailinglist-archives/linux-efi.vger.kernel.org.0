Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6D36FE755
	for <lists+linux-efi@lfdr.de>; Thu, 11 May 2023 00:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236175AbjEJWlB (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 10 May 2023 18:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjEJWlA (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 10 May 2023 18:41:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB509270D;
        Wed, 10 May 2023 15:40:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 826E66150C;
        Wed, 10 May 2023 22:40:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29320C433EF;
        Wed, 10 May 2023 22:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683758458;
        bh=tF9aA3aQ1D5AlFCI2Nv7HBfN5V1j5FLcOx2tAAEBbHM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Il5YzSjPIXLXdPaI5/sW6jzyUD7EokkmmqfKlVwieWUDC1E1E3AG1h3vprJUyD+5W
         dl8VUoMaNNvPGipJNCal3ogW7ZjV50bqESSfawYg5rTCCVwQANxBoaAEC3v4sqlOe/
         uiv5xj3dWrewBJufJ4WthVEvVUqGyJ1CTqcbr8pqK0RHjZs+ndZU1HcCWV1C9ZMmpD
         oarS9fwjus+jKN5ZixWyJ+7QhSKd03ek6HlSEARjdUQJoADPiBxSyoB4fQ+kAfTjlM
         2Ld3lLaaYiuW4ct4ZGMy8akKFz8dD/gWFs/a6zfW69YsqSylolwmzjkEfftYmsD5DH
         PPrU1k3h0+vBg==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 11 May 2023 01:40:53 +0300
Message-Id: <CSIYK2ZJ6YRH.29WEQTLNYMDUF@suppilovahvero>
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Ross Philipson" <ross.philipson@oracle.com>,
        <linux-kernel@vger.kernel.org>, <x86@kernel.org>,
        <linux-integrity@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <iommu@lists.linux-foundation.org>,
        <kexec@lists.infradead.org>, <linux-efi@vger.kernel.org>
Cc:     <dpsmith@apertussolutions.com>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>, <hpa@zytor.com>,
        <ardb@kernel.org>, <mjg59@srcf.ucam.org>,
        <James.Bottomley@hansenpartnership.com>, <luto@amacapital.net>,
        <nivedita@alum.mit.edu>, <kanth.ghatraju@oracle.com>,
        <trenchboot-devel@googlegroups.com>
Subject: Re: [PATCH v6 12/14] x86: Secure Launch late initcall platform
 module
X-Mailer: aerc 0.14.0
References: <20230504145023.835096-1-ross.philipson@oracle.com>
 <20230504145023.835096-13-ross.philipson@oracle.com>
In-Reply-To: <20230504145023.835096-13-ross.philipson@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu May 4, 2023 at 5:50 PM EEST, Ross Philipson wrote:
> From: "Daniel P. Smith" <dpsmith@apertussolutions.com>
>
> The Secure Launch platform module is a late init module. During the
> init call, the TPM event log is read and measurements taken in the
> early boot stub code are located. These measurements are extended
> into the TPM PCRs using the mainline TPM kernel driver.
>
> The platform module also registers the securityfs nodes to allow
> access to TXT register fields on Intel along with the fetching of
> and writing events to the late launch TPM log.
>
> Signed-off-by: Daniel P. Smith <dpsmith@apertussolutions.com>
> Signed-off-by: garnetgrimm <grimmg@ainfosec.com>
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>  arch/x86/kernel/Makefile   |   1 +
>  arch/x86/kernel/slmodule.c | 520 +++++++++++++++++++++++++++++++++++++++=
++++++
>  2 files changed, 521 insertions(+)
>  create mode 100644 arch/x86/kernel/slmodule.c
>
> diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
> index 3d2a33e..ee3fe300 100644
> --- a/arch/x86/kernel/Makefile
> +++ b/arch/x86/kernel/Makefile
> @@ -73,6 +73,7 @@ obj-$(CONFIG_IA32_EMULATION)	+=3D tls.o
>  obj-y				+=3D step.o
>  obj-$(CONFIG_INTEL_TXT)		+=3D tboot.o
>  obj-$(CONFIG_SECURE_LAUNCH)	+=3D slaunch.o
> +obj-$(CONFIG_SECURE_LAUNCH)	+=3D slmodule.o
>  obj-$(CONFIG_ISA_DMA_API)	+=3D i8237.o
>  obj-y				+=3D stacktrace.o
>  obj-y				+=3D cpu/
> diff --git a/arch/x86/kernel/slmodule.c b/arch/x86/kernel/slmodule.c
> new file mode 100644
> index 0000000..70dcff5
> --- /dev/null
> +++ b/arch/x86/kernel/slmodule.c
> @@ -0,0 +1,520 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Secure Launch late validation/setup, securityfs exposure and
> + * finalization support.

/* Secure Launch late validation/setup, securityfs exposure and finalizatio=
n */

79 characters (max length allowed is 100).

BR, Jarkko

