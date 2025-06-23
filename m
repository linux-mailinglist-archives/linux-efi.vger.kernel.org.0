Return-Path: <linux-efi+bounces-3922-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F18AE4C44
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jun 2025 19:58:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93DDC3AA53B
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jun 2025 17:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A245029CB47;
	Mon, 23 Jun 2025 17:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlXQF5u+"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A781B4242;
	Mon, 23 Jun 2025 17:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750701511; cv=none; b=a9G0de3u3LSCfJdPVSh2dlEaIz9Mf2cbANP/eI2AEEU80RaUWy07/EjFvh2GCMi0G84WZo995+yCNqmVkI8C3+FkXgyxJ/+5sUoeoTWDZP+k1IKUMyFT1aIJBOWvIFTlgGCRYz2yKPyDnMUxLk/t5rCr99F3IlaRqa790uTZcAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750701511; c=relaxed/simple;
	bh=0oyJae6pjjJ7/j+FfrzrjTRR9oFJ/floYiWB5RY6DTo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sBQCEljeSwuy50/Gg6Sdil0X47QKxZjXUhMxsGxc8TG04LqcXjQgKwTrskJafgNeYHIwx+41c+Yy8GPJU517trDQHBDvgeSI3JeaTPuuKL2aIggok8NmTN8r3ISgEQn2LDJFj8z65HBVbKZVGfUySkDJTSKfmQinC+7D/RZYq4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mlXQF5u+; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-553b60de463so4787991e87.3;
        Mon, 23 Jun 2025 10:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750701508; x=1751306308; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QtJGbIs6LvfGRPvm/XlRtdTtqOrMi3Ddyem3mMgcu1g=;
        b=mlXQF5u+S5QQM3h6dFSc6mFlzY1iutT2Db7dhyS5dZNflM/g3VCpGEItZnTpfxlZIp
         tm6s93E5EthWatwGAkrKr7EBuTBcAhSVLkxeGFkpurjhDSNRaQc9jVjmlATzTlK2wFlY
         WF3KmRjKTAu1wttXWH3wqsXqKPYSfRHlg4GTeTcab5Xxd02ZYS5IzRuZyo13gvLIAIeE
         IC3lU6EqiKQ+p3rgPuTcXxUwvmmsF6q+WCXpMZzsOW5LXG2JoHqFtiZY69CICAWqBdxr
         8MhORgDVmV6TJawE9l5mKs/Qy/4u406y5rVTc8FbKWYHlxvRQRvhq5Gb5X3eip8UuWY/
         FYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750701508; x=1751306308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QtJGbIs6LvfGRPvm/XlRtdTtqOrMi3Ddyem3mMgcu1g=;
        b=YnCcpcuyRxedgLf91hvCP9/x8QRuW0FL2kTxSrf9wHzDUspwaEHsD1P2sHq0lgCOw6
         4JNzfi2EnEhFjHCqHWJY1LwnBRwi/1SG44F+R/65SOFpXnZqwzGwS1xZutE9Oopfc6Uk
         MHN1AcUJuIMYsBAx+Lvh57hpk6j5l8HdbvKgFAIf8AhseyjHWffp+clbO080MS6A+4id
         QbfKP1ks0QqzVi3TS/ZDLYaUf6VZS3QxNQp0ZSdQv2Q5H9MC9ALKxnxAx58QV51K9Kw7
         SgG2mAd2Dq8HqvEvldFjO8VPPY64dEUxWLV1A5wzpJqavemLWX1pFcHAcZcjQ5+5y9Ch
         p75Q==
X-Forwarded-Encrypted: i=1; AJvYcCUESlhYKkzFtWI316zEy+PYlpg0zwAJU5LmwhBe5fMGpkykvBD3H4pYimQEZvORp8cdiwGaru0pwP6ieixD@vger.kernel.org, AJvYcCUVxWFZrxc84pZ5Ay4A6p5ntUjTByoFNwRC46DFuz9sP/MQ+4tO8lH5zIWd6om5o6aotbUWhykYR38=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyodLqtgUhy/LJE0hiExkWdkt02z1wyZJBTjk6CZlER2jfHF4m
	cKiqv3gAISqmwXame3VNvg8vQtVCbLytjgKz3/g1wx4y97eph8I8J8yWl0B5GqKCsk/aitMy0s4
	OpKmWb+J1E7Q6hfG6mcrQmaaEZ6LnIDHz1ac=
X-Gm-Gg: ASbGncth3vUXljhOUyKE/O7rOUEdzwH43vrtpfNtP7kYElgeQptG4EaDE2b4P3ncxOo
	Igl7HOVpEF+5vt3j6vU7TpDtmwgbK8+QYXMUlHiQINHbLE6oD6nSxiz/23KVUsAp1FlnSAPfLSn
	Z2tJovPfEOI6BqqwnzcDaCBMm7mhYCn7mfIHuCrmoufH9BZHJlULdLmK2t8Q==
X-Google-Smtp-Source: AGHT+IEChVSVBHgLMXfgLZq3c+t76wK5AFf+S3ocYX9HTNt0r7MB9AG0BUcLLb0rSgbuiD1933a/f7obl+jTfUzMjlY=
X-Received: by 2002:a05:6512:1396:b0:553:659c:53fa with SMTP id
 2adb3069b0e04-553e3b9a33emr3949838e87.5.1750701507556; Mon, 23 Jun 2025
 10:58:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2D63735B-FA76-428E-8F68-8EBCAEA0985E@zytor.com> <20250623161741.623-1-khaliidcaliy@gmail.com>
In-Reply-To: <20250623161741.623-1-khaliidcaliy@gmail.com>
From: Brian Gerst <brgerst@gmail.com>
Date: Mon, 23 Jun 2025 13:58:15 -0400
X-Gm-Features: AX0GCFv72i-bOmyN49cFldCw0YnHCOXhqhg4Uv_TqUrUC1HJqaanGgEQxzuBBcU
Message-ID: <CAMzpN2j+nz60C7irRvXF4Ni94Wj9mcLGoPe6BF7Y6FPbeV2xqg@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] Recieve boot_param from RDI Instead of RSI
To: Khalid Ali <khaliidcaliy@gmail.com>
Cc: hpa@zytor.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, ubizjak@gmail.com, x86@kernel.org, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 12:27=E2=80=AFPM Khalid Ali <khaliidcaliy@gmail.com=
> wrote:
>
> > On June 23, 2025 1:15:23 AM PDT, Khalid Ali <khaliidcaliy@gmail.com> wr=
ote:
> > >From: Khalid Ali <khaliidcaliy@gmail.com>
> > >
> > >Adjust the kernel entry point to recieve arguments from RDI instead of
> > >RSI.
> > >
> > >Signed-off-by: Khalid Ali <khaliidcaliy@gmail.com>
> > >---
> > > arch/x86/kernel/head_64.S | 4 ++--
> > > 1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > >diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
> > >index dfb5390e5c9a..d24fea15b6a6 100644
> > >--- a/arch/x86/kernel/head_64.S
> > >+++ b/arch/x86/kernel/head_64.S
> > >@@ -43,7 +43,7 @@ SYM_CODE_START_NOALIGN(startup_64)
> > >        * for us.  These identity mapped page tables map all of the
> > >        * kernel pages and possibly all of memory.
> > >        *
> > >-       * %RSI holds the physical address of the boot_params structure
> > >+       * %RDI holds the physical address of the boot_params structure
> > >        * provided by the bootloader. Preserve it in %R15 so C functio=
n calls
> > >        * will not clobber it.
> > >        *
> > >@@ -56,7 +56,7 @@ SYM_CODE_START_NOALIGN(startup_64)
> > >        * compiled to run at we first fixup the physical addresses in =
our page
> > >        * tables and then reload them.
> > >        */
> > >-      mov     %rsi, %r15
> > >+      mov     %rdi, %r15
> > >
> > >       /* Set up the stack for verify_cpu() */
> > >       leaq    __top_init_kernel_stack(%rip), %rsp
>
> > This is an ABI.
> >
> > Nacked-by: H. Peter Anvin <hpa@zytor.com>
>
> Peter, thanks for the response but if i ask you:
> What is specific reason that this patch is wrong?
> Why used RSI instead of RDI at the first place?

It is defined in Documentation/arch/x86/boot.rst

IIRC some hypervisors can boot the uncompressed image directly.


Brian Gerst

