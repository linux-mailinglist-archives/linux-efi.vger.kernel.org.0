Return-Path: <linux-efi+bounces-39-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B0D7E86A5
	for <lists+linux-efi@lfdr.de>; Sat, 11 Nov 2023 00:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 538911C2097B
	for <lists+linux-efi@lfdr.de>; Fri, 10 Nov 2023 23:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC603D97C;
	Fri, 10 Nov 2023 23:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nc+JPMYx"
X-Original-To: linux-efi@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D261C3D3BA
	for <linux-efi@vger.kernel.org>; Fri, 10 Nov 2023 23:41:48 +0000 (UTC)
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94243C15
	for <linux-efi@vger.kernel.org>; Fri, 10 Nov 2023 15:41:47 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-dae71322ed4so3207755276.1
        for <linux-efi@vger.kernel.org>; Fri, 10 Nov 2023 15:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699659707; x=1700264507; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0ltVk616BPyOUD6M/e4/KeQLo/53b8eRdyGVgEa8ceQ=;
        b=nc+JPMYxEuYFV5eyQS4d7VWWEPgw2sVLTlkiVt05tzOG5zheOwns0mOPOAfnpNk+B/
         pzycFyiOG14zr/YJlyS8D1Ejfp44KUp1Zs7j+SYjGOo+6tBeTZ68zYAoHpsII1gr3rTX
         RJmOaQBh0oBy3qxetCWLz9Zm1qprGagTg6cXPq7CztW6WS7dyUoWAWAvUuebXQ+IOc9s
         HCewTcqiCbq7ni/DCmmgPduGle7iVz6fOz2x8xxjzntXGF0rmheLM8oYt4jw84ifqiB1
         HzPU6G9C37Y+4DgBasNx8A7bSmugplyvYaKnFQyyZPu8XXGCjtQyCA7A65ZNVglksWf2
         MGjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699659707; x=1700264507;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ltVk616BPyOUD6M/e4/KeQLo/53b8eRdyGVgEa8ceQ=;
        b=gWkoJ6TK3uLGzKN0wwwGQIhyusgCwCtqUUwm0IP/UeXtlqmNMijVkbm9OLrZswO0SP
         hNIYjKnEMAiIQY7tFK144RaZJ4h1+kDqnmjm6HduyaQEweY8PckJ0SfUqq9PHd92+PH7
         VWJxBWuPyZt2M5EXsqYQ0rSeAGQJ5Q5C3ZpU7K4XpWVqqOpqyDm9L3huG+oeA9h6e4NR
         KYoxVU2GNy5y8tHk3iHPaiocEf6SmQ91QaCx28qU31qPqv+0xGLXAGXqSsKpx7IHrqYt
         5+LpcX9xRzs60HW9eJ+kNOQJD8tcztqED9XIcQ2rYnWRN+jV4gxZSlTu6XPXdeLFUiuT
         5G3w==
X-Gm-Message-State: AOJu0YwRkI9oHPg7MiHKH8cOpiaDB0Mg3KUYVs64eUUxhErwEhtoDOKm
	1azelLnGF/hh6fZIcyJRuAb5MO9esRI=
X-Google-Smtp-Source: AGHT+IGBsfnu9DDfS0QMrc7xY+SRPf/NS4ruISrqsheEvpErABAEKuj1dLba039RzL2yA5d0Qtqev7ecdb8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:182:b0:d9a:ec95:9687 with SMTP id
 t2-20020a056902018200b00d9aec959687mr15566ybh.11.1699659706873; Fri, 10 Nov
 2023 15:41:46 -0800 (PST)
Date: Fri, 10 Nov 2023 15:41:45 -0800
In-Reply-To: <20231110222751.219836-11-ross.philipson@oracle.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231110222751.219836-1-ross.philipson@oracle.com> <20231110222751.219836-11-ross.philipson@oracle.com>
Message-ID: <ZU6_uUe45qAx52mI@google.com>
Subject: Re: [PATCH v7 10/13] kexec: Secure Launch kexec SEXIT support
From: Sean Christopherson <seanjc@google.com>
To: Ross Philipson <ross.philipson@oracle.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-integrity@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-crypto@vger.kernel.org, iommu@lists.linux-foundation.org, 
	kexec@lists.infradead.org, linux-efi@vger.kernel.org, 
	dpsmith@apertussolutions.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, hpa@zytor.com, ardb@kernel.org, mjg59@srcf.ucam.org, 
	James.Bottomley@hansenpartnership.com, luto@amacapital.net, 
	nivedita@alum.mit.edu, kanth.ghatraju@oracle.com, 
	trenchboot-devel@googlegroups.com
Content-Type: text/plain; charset="us-ascii"

On Fri, Nov 10, 2023, Ross Philipson wrote:
> Prior to running the next kernel via kexec, the Secure Launch code
> closes down private SMX resources and does an SEXIT. This allows the
> next kernel to start normally without any issues starting the APs etc.
> 
> Signed-off-by: Ross Philipson <ross.philipson@oracle.com>
> ---
>  arch/x86/kernel/slaunch.c | 73 +++++++++++++++++++++++++++++++++++++++
>  kernel/kexec_core.c       |  4 +++
>  2 files changed, 77 insertions(+)
> 
> diff --git a/arch/x86/kernel/slaunch.c b/arch/x86/kernel/slaunch.c
> index cd5aa34e395c..32b0c24a6484 100644
> --- a/arch/x86/kernel/slaunch.c
> +++ b/arch/x86/kernel/slaunch.c
> @@ -523,3 +523,76 @@ void __init slaunch_setup_txt(void)
>  
>  	pr_info("Intel TXT setup complete\n");
>  }
> +
> +static inline void smx_getsec_sexit(void)
> +{
> +	asm volatile (".byte 0x0f,0x37\n"
> +		      : : "a" (SMX_X86_GETSEC_SEXIT));

SMX has been around for what, two decades?  Is open coding getsec actually necessary?

> +	/* Disable SMX mode */

Heh, the code and the comment don't really agree.  I'm guessing the intent of the
comment is referring to leaving the measured environment, but it looks odd.   If
manually setting SMXE is necessary, I'd just delete this comment, or maybe move
it to above SEXIT.

> +	cr4_set_bits(X86_CR4_SMXE);

Is it actually legal to clear CR4.SMXE while post-SENTER?  I don't see anything
in the SDM that says it's illegal, but allowing software to clear SMXE in that
case seems all kinds of odd.

> +
> +	/* Do the SEXIT SMX operation */
> +	smx_getsec_sexit();
> +
> +	pr_info("TXT SEXIT complete.\n");
> +}

