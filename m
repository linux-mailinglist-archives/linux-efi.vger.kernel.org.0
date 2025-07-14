Return-Path: <linux-efi+bounces-4338-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBFCB04573
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 18:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A27B93BBEF4
	for <lists+linux-efi@lfdr.de>; Mon, 14 Jul 2025 16:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82337246BC1;
	Mon, 14 Jul 2025 16:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kg+7iDZV"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD0E13AA53;
	Mon, 14 Jul 2025 16:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752510626; cv=none; b=skYDedrviffapcuRy7Hm7j3OGs7SjjUBjku/bNatGZ+1FGz5l+PnfMkteWj/d3USzzPyke/MlLcPNq7gRRJm2SfX8QDBX1z5TFhAFf40WquDIdwOGLBYGhfzRDFMl4GuaV0lS4zZ/Ya5ZaqlcNRcjN4uJKIKBBeSTkG5I4hXBSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752510626; c=relaxed/simple;
	bh=lLEsaBZOlrQnGfQntry0h0Gc0xbjURUDnEKTrwol9tY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=shgthJNrENVuj7o5QDlzyzVn23ryHZ/MGu85PileCOm8/Wp3dR8Uad/XBa7QhM6S1wdISiRlyS5tttrDeb3kxz2Ywdo96qLpa5Al1hfXU6IG0jNjig/QwdtMnYtYhr/h6ok9LpB5gX280eiB7KYAUwqHIxv653zqoGjyaqBlUnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kg+7iDZV; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b350c85cf4eso466460a12.1;
        Mon, 14 Jul 2025 09:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752510624; x=1753115424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D+8sgm4KGNU/qNdB+13y9KyGhaX2MKC48G1yc7u2rJ0=;
        b=Kg+7iDZVWt6qdMbnyIH1q7E/y7QAXLgirxa8fTYyzVhj2O5PWxB5eWEawOxw+Ksb20
         xiHfpgeR7U/VVmohhU6Uff85njd0oT8ayYo3/8OfZDqOqsxwSr8moJVYUByHQPuG6roF
         PuT54D1JhuH8dA8X3Ncw08bDqctDBNpXizZ55reVVk4EPLPTClmRDaGBA63Z8JuhRPzC
         FYXGjkdav3MajYi4+LRuauqXt8BHthXD2qtYOVcRa2XRZ+IPal+cSgFNPx4C9JQiUItA
         DwWLTeTQ2c/aRbzjH0fJDSaVfr5i5bJG+4Vkj5deAaIxfGYpzxX862nFB+ODm+q1OtVO
         yLuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752510624; x=1753115424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D+8sgm4KGNU/qNdB+13y9KyGhaX2MKC48G1yc7u2rJ0=;
        b=D6Nvf+CCsPtiDjStnzHMYC5uKtjVEgakprXGBfOFsxjUQe8Lbpsj1KtD3W8xctPixv
         6kGIr8YJfbD8qp5BIrLuSDGdA2bCHotlHfJJVG1ksDyFQWjHda4AMJzHPqHSlkdgREbj
         t5QfVqQIdW5IXjF6dIw0rpdUl2C92g+5pdC7gRDrZuIOn8qtz3QOn4EiaT9kfbzq+0v/
         YsDMv7ay0cQbfvDTdfsOQ16H/jnWgTXQY+dTkE3rsB/LTO8MNk4lMrSxC9a0/knKMd5M
         MCLsv9J21RV/+hCs+w4BcEsU69COvdTw0a54Tdhp+Fd6PgWF5yWc29CYZpbeNIPxKCUo
         BsJg==
X-Forwarded-Encrypted: i=1; AJvYcCUsb3RUA5NZ9kBCdvPQgu6VxA0xbpaq4YpaJX2Nwb1Bneo8I3IdayIo3n2XvEwyW95gifPYA5NJDwC5DjGe@vger.kernel.org, AJvYcCVZ29RSZoC2hIiAUN2bp8DqfjEM2wL37qwlfyMnQXxJbbcum8TbAJKiyl08FJOcvRU8k7bn0uZjWv0C@vger.kernel.org, AJvYcCVvvydYOaWdHEzrjU4lXJj3EJEn3sEBBWI7PFWsxdXluxSsi4qNGfpLLofgd73zoSMSDJ/Oc9gNYZY1H6Ir@vger.kernel.org, AJvYcCVxWje6TEdc7+I3vB9Z4YnU8w/27MQPygKxsZpHwbOAyZtnIr9wtOBl1Jyg9sK/q926JfY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN5rR4wXaQbtmEOJO6DhVP1ID2cV4vy6k80nLI5Ht2pp7Hfat3
	LJ2LpXHtQrLcDG814syUWypeQQ+cspvipZZs9lM8MTt1WFkN2VGWOyk6AwnMS59t9S4ZKx5kgrJ
	cc0gHdx6zY68nZzb5yHiGcshJmogofVQ=
X-Gm-Gg: ASbGncuFSNrKhlePhEN+liQq+CqbMPU9Z/+LbAVJFnBPcBEGN4UmsbSBw+Hvc2B6pHR
	3XUOkjocotfWLjwQi5fMyZU/OnSY5SMAKdm77hh5r/yi4UXzFEUl5KldTKC2BCUiUncrrb1dL6e
	VQgR0QJ9rtkgjT208PXcX6YFyHPG8aU1fzryMQYbI3wFQ1c8kcPicg/PL9Va+6obpNpO15xoGAs
	54ycQ05
X-Google-Smtp-Source: AGHT+IHyYvv5+3JWpqsKuSY+wK3z8BqR9a/T94bPsj6wT6Sjx0azXqcCyCWcvR/Ia/9kNSO+F2zypZBSntO4e7l+ce0=
X-Received: by 2002:a05:6a21:6d97:b0:233:38b4:7983 with SMTP id
 adf61e73a8af0-23338b47df1mr5041293637.3.1752510624098; Mon, 14 Jul 2025
 09:30:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250714102011.758008629@infradead.org> <20250714103441.496787279@infradead.org>
In-Reply-To: <20250714103441.496787279@infradead.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 14 Jul 2025 18:30:09 +0200
X-Gm-Features: Ac12FXyg-TiF3LiiNdjUgzoE4zwXcE3ylmR03od-QeLGVHK8BYgEqxSLcgHYRQ4
Message-ID: <CANiq72kP7_24ChdQ+vDg+HWJB-4mKWvB9P33C9O=0W_kLt0+eA@mail.gmail.com>
Subject: Re: [PATCH v3 16/16] objtool: Validate kCFI calls
To: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org, kys@microsoft.com, haiyangz@microsoft.com, 
	wei.liu@kernel.org, decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com, seanjc@google.com, 
	pbonzini@redhat.com, ardb@kernel.org, kees@kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, gregkh@linuxfoundation.org, jpoimboe@kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, linux-efi@vger.kernel.org, samitolvanen@google.com, 
	ojeda@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 14, 2025 at 12:45=E2=80=AFPM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> Apparently some Rust 'core' code violates this and explodes when ran
> with FineIBT.

I think this was fixed in Rust 1.88 (latest version), right? Or is
there an issue still?

    5595c31c3709 ("x86/Kconfig: make CFI_AUTO_DEFAULT depend on !RUST
or Rust >=3D 1.88")

>  - runtime EFI is especially henous because it also needs to disable
>    IBT. Basically calling unknown code without CFI protection at
>    runtime is a massice security issue.

heinous
massive

Cheers,
Miguel

