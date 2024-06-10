Return-Path: <linux-efi+bounces-1191-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0403902838
	for <lists+linux-efi@lfdr.de>; Mon, 10 Jun 2024 20:04:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25988B226D7
	for <lists+linux-efi@lfdr.de>; Mon, 10 Jun 2024 18:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E3A14B95F;
	Mon, 10 Jun 2024 18:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rP7ybkn1"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB93214B084
	for <linux-efi@vger.kernel.org>; Mon, 10 Jun 2024 18:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718042644; cv=none; b=GdiJvmaPETdajMqjxRfDJSU6SYfQi/4xU/RNhNB6cWJtZcRW9bGzvyALU5CIA01vTyS47oR76P8F4rwtIGtAyR7XxVw57DlmiKU6a21NifAOHkmgwzhIwDCbOecJIahYxICyi3aZlcpc08nIcfR5FeImzvAvOjl8cdvyYtF9/co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718042644; c=relaxed/simple;
	bh=Sb+UpowW174zRD6Djwhm9AHjflSswLhp+5QE/omPIYE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W6a/SXN6H+ZcVfCuuqzLj0wj8jJUAovVukiCpmm042BwkDz7Tsf0IOY6+CcfzdXva9Q/TiEix2XSsUQStrR0b1A1lO1Xuw6/0vvHY4aa1tBCHog/+Kp6lOibgFHbfgTT1QaAO2XoZSMI6Y2XLX2/So0QELwKtvwg4PlBEyj/Yhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rP7ybkn1; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-518948e1ec8so262e87.0
        for <linux-efi@vger.kernel.org>; Mon, 10 Jun 2024 11:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718042641; x=1718647441; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Sb+UpowW174zRD6Djwhm9AHjflSswLhp+5QE/omPIYE=;
        b=rP7ybkn1aOSXa8TwOJNrENCEqHyQk2lqeiokSX+awfsAfXJkz71OPcZLmigIVHIKFz
         th02pUFXme57TyzfUuhXdjU6Q0gqTlgjSPX7dbI1vVpQST5oBi3uPxHufSy6l0MtS11N
         xpZZTIO2//KYep1TOgj+1wmDNXahLTh1PTFWcPcAReKabCvup/6agwL1VRFlMplj4jKL
         4uCafE8ZNabF81+mJV9ESURv/MbwF6zJfcNKap29d2l3NTWhzMGthkp6QAHE+s65LcHJ
         PBzb5HTvhS3tj/7NReXK57yVDl7WKuMyYjcyPaUi9put4/Bq/ikUUX3MrgFrY26gmRhN
         CVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718042641; x=1718647441;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Sb+UpowW174zRD6Djwhm9AHjflSswLhp+5QE/omPIYE=;
        b=o8nXJjSf736xVyxVTE/AjjGw4Lb5zs0hmeBWvmdSprmJCiNpu3FoTAzuhYVzGn4MiI
         R1DmgbsGxg/6XwtMiTk3R5+TVlfugSWtwVbrYkLU5Y+pD6686gyXMuHKt5EeUwQmPbIr
         iv9ijm6aGshxMWBdG0OS7UPjKK3YRkExIYZutyCtHg9K6vVlFSeb+jwnDmaf642tWxzP
         9WncjgUSNR73FAlTwErD2spVsOQSpx9+Qv/fbZZwKYKB5SmfTvJyZ27VOFkJe32PwWLg
         O7r3U6E3UK4FPCD7ezdSRb0b0Ozks/xWcABT5Y7gCmoufX+H1CHCTojDo2hVK64OWbhI
         t4gQ==
X-Gm-Message-State: AOJu0YxCQc5pxQhlhkwZpZ0q/arjV8n6V+HTEY6rs1bKb2XOKDUUElPc
	iIEmuY5ZPZK/i4hjB0ggtMOO0TdJZE/V+QqtincYEE9rHjWGVQdL9mGisMRUClc2GtKlRwwo4E5
	nBuQHeP0HUXTYb1sO8XvfQW9Q08L2JSFvr4Q+rba5xwFjF+JdFg==
X-Google-Smtp-Source: AGHT+IGjyUmh3m0D1HRu+7+WNv8PDOE44sjH+Qpb7P2RRNaH4eg3OClqRtOvz+u1gLjcJZFNuZnSKZ7sJ1pM5jk9oFA=
X-Received: by 2002:a05:6512:280a:b0:52c:905b:8771 with SMTP id
 2adb3069b0e04-52c93b0a0c8mr12336e87.0.1718042640809; Mon, 10 Jun 2024
 11:04:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAAzv750HTnposziTOPDjnUQM0K2JVrE3-1HCxiPkp+QtWi=jEw@mail.gmail.com>
 <CAMj1kXGvdRwboAZZGEvOh2_wFjzhc1OY2F5BBcYJF5ZhT8=Bzg@mail.gmail.com>
In-Reply-To: <CAMj1kXGvdRwboAZZGEvOh2_wFjzhc1OY2F5BBcYJF5ZhT8=Bzg@mail.gmail.com>
From: Nicholas Bishop <nicholasbishop@google.com>
Date: Mon, 10 Jun 2024 14:03:49 -0400
Message-ID: <CAAzv752N7mZ58uzMkaxAFDbefCLSqtLkZBVXXuY00RA+UQ6ppw@mail.gmail.com>
Subject: Re: EFI mixed mode boot failure
To: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Which platform/EFI implementation are you using?

Testing on an Intel Compute Stick (Cherry Trail) and QEMU+OVMF. (I'm
using an older build of OVMF because recent releases fail on ia32 with
an exception early in boot for me.) I'm using a custom bootloader that
invokes the compat entry point.

> In any case, it seems your analysis is correct, and no BSS clearing is
> performed on the compat entry point boot path. So please check whether
> something like the below fixes your issue as well.

Confirmed that this boots successfully on both the test device and VM.

