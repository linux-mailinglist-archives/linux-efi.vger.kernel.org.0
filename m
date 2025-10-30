Return-Path: <linux-efi+bounces-5272-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2872C226F1
	for <lists+linux-efi@lfdr.de>; Thu, 30 Oct 2025 22:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4829C188C8BF
	for <lists+linux-efi@lfdr.de>; Thu, 30 Oct 2025 21:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41F3E311944;
	Thu, 30 Oct 2025 21:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Evh5FF7N"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D2D32F4A0A
	for <linux-efi@vger.kernel.org>; Thu, 30 Oct 2025 21:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761860227; cv=none; b=it9t53XWCKb/f2GiYvfsGHVn6bLmX1VgTVkENQ9PjFsCvbiRL2+t6TO4empJqX4dxpD6S8TKbAv5i4ZW30TPTiWk7STD247oZGW7cLfuxeNYaxpcTcGpjOs54uzif1rgem9BWDm/FvnEpxHA3kZH1srD+6XZqCPqh2ZZu6iXsOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761860227; c=relaxed/simple;
	bh=45jfdJnyJ32bvuggaDRa8h9Sl7RrgHGsxTBiE2SnqnM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ekKFWo9ZjDSkTJ+GzdWvTttvBwEs70XNHsZAHQ24259XHipUDT3rHRmBkSEMzhHqZvKwqf/spplU+z1fb1go/MtvtSsxqst2+V6ibdOCfyueXiNdDmaZKGlR4DfdHTQ4ukSiAb/SPT8/mO4E+03iUnAwQvto3ArdWzdE8dROA5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Evh5FF7N; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4770c34ca8eso13913005e9.0
        for <linux-efi@vger.kernel.org>; Thu, 30 Oct 2025 14:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761860223; x=1762465023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HBQJ8NZZeDhVExk7zItWUyrPMSm4Navew7MC0raFrQo=;
        b=Evh5FF7NeH2CdnS6fyJOz0yuZNQpRoE39f8hPOsiPZSAa4r0HO4Td40cQ2JqR7p98s
         kW9sC6uVKHfymR6Bwc0RHT0UiLqB+1c08pkfJ9FwC0m2t65GZbMbJ7B1qzNteXyY+ZWk
         cu9OkXFtQpgpuzCF84asi+QaaZDkun3OgofDQX8GxG5rzyXsyY4scEYMV+LesWfF5HRN
         stIClQywZY0X9Y//nNewmkxAHUX6V8TogoKwg87rS8jC22n7mhPoDr4zCV/shaUFAo3k
         Vlm4CPXn7Z1RpurzoP3d/1Fs5OcKWDetXRQk9Uz7YfLPG3w5xlKoeVDAVNrQ92KPsKLN
         kv6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761860223; x=1762465023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HBQJ8NZZeDhVExk7zItWUyrPMSm4Navew7MC0raFrQo=;
        b=ix2Fw+lugU9KbjJP3lBWxuqxIbil9TwZUAINS0Js5k+L0d4l4jK2l/W0UO7QXCirRF
         F9KYkBnmh/CX9A2oG3b235dZPh/ZoxljjY1P4LlcOCOdjEszpcl7ow8iZos/LdC/GZ1y
         HwNIAmR5ZNiRYxlYWkNb2550xHAdehCF7sM1DVUBgoWIq5T8eZZklHzhH3aTPplnO2Bt
         Z1J/ALSlG5JlNrcNZ0/Tsd/Dw/uDTIWbc9nTGKk28KfvgS9eFu4duq/j6ubGmVDYGfSp
         fFHjKQGql4Sp+ji9QPAnPqd45XIKAEW62gi/z9yqzF9UI7l0bSBBzJKD3o81py4iHls0
         zOvw==
X-Forwarded-Encrypted: i=1; AJvYcCUzgRuW3WP87N4+BK/j2fzjuBqnZvlOOrkLCqgxVxCHa/UXRH1D2k8HYozvHnNk+AZV0/SOnFuhgzk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw67RgTG+FwDjhNYNHbMxJ6+VA7w0cseZRUBs2G+s7OblqOLB3N
	y7E/DPeHRrdn5VmAr38ozO637CUi514tEnRbk34H20t6OweKfwDA3UqR
X-Gm-Gg: ASbGnct9bCegyZnNLTKf5MKjoQo55rX0pdXi9y90FT7nrOkpaPLEhZc32AVkTYeulpk
	N8fOOM3aahATJPKvoqvmPJjkt2oHh0HVwRdmPIQYuDH9EYp7xIgM5Or6FNj88x/Jo6m0PO02wnV
	U3e11ktAAPxNrrENJo1voSMdATreHwgddgQupdR/q/lUPBI1zeD00XT/q5FZL5Egkfjhb2/5uHr
	W3pPv1F2zveEaKxVKKQK/yTRwWXSsT8LCc3ni9bhe1VCWynh6EMJvIcMpPpWrsQJsDsv00Kr488
	A1f7UKfUi2H3Romddmg8NiBZ2FiE+Q5IdkxMy4pdP7id/vvlc4VROBcAZ8B7aY0Or5hwarrFrfC
	Y7XcbdMKFffo4BXOhIMnfSEA2pMdOlS8CWqJCyFGyAMnU4TRfY9Bj16bnKaRTLWH360cFaRV6DL
	mcRUZbbPr9ibgs8m26AS/x0TH2ZhZPfsGRNuQP8cKM7Q==
X-Google-Smtp-Source: AGHT+IHL5HKRR2VQHGsF+tRPHFz6hmgUmkPnqqQQjatvWEU2WCyYG6/w1jSGFQ7BPsCBPfDzFNjvNQ==
X-Received: by 2002:a05:600c:528e:b0:46e:450d:e037 with SMTP id 5b1f17b1804b1-477307c213fmr10872665e9.5.1761860222541;
        Thu, 30 Oct 2025 14:37:02 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429ba445463sm4164266f8f.10.2025.10.30.14.37.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 14:37:02 -0700 (PDT)
Date: Thu, 30 Oct 2025 21:37:00 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Sohil Mehta <sohil.mehta@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, Dave Hansen <dave.hansen@intel.com>,
 Rick P Edgecombe <rick.p.edgecombe@intel.com>, Thomas Gleixner
 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
 <bp@alien8.de>, the arch/x86 maintainers <x86@kernel.org>, Dave Hansen
 <dave.hansen@linux.intel.com>, Jonathan Corbet <corbet@lwn.net>, Ard
 Biesheuvel <ardb@kernel.org>, "jpoimboe@kernel.org" <jpoimboe@kernel.org>,
 Andrew Cooper <andrew.cooper3@citrix.com>, Tony Luck <tony.luck@intel.com>,
 "Alexander Shishkin" <alexander.shishkin@linux.intel.com>, "Kirill A .
 Shutemov" <kas@kernel.org>, Sean Christopherson <seanjc@google.com>, Randy
 Dunlap <rdunlap@infradead.org>, David Woodhouse <dwmw@amazon.co.uk>, Vegard
 Nossum <vegard.nossum@oracle.com>, Xin Li <xin@zytor.com>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>, Kees Cook <kees@kernel.org>, "H. Peter Anvin"
 <hpa@zytor.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>, Geert Uytterhoeven
 <geert@linux-m68k.org>
Subject: Re: [PATCH v10 08/15] x86/vsyscall: Reorganize the page fault
 emulation code
Message-ID: <20251030213700.1e98203e@pumpkin>
In-Reply-To: <e3c7987f-7f8d-41bb-9d4d-966f35941757@intel.com>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
	<20251007065119.148605-9-sohil.mehta@intel.com>
	<a33d59c7add98dd9ef352ac95178821dbcd0ce0e.camel@intel.com>
	<3e3d2426-6296-4a61-beae-4e3ff5d60f2c@intel.com>
	<f4ae0030-9bc2-4675-ae43-e477cd894750@app.fastmail.com>
	<e3c7987f-7f8d-41bb-9d4d-966f35941757@intel.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Oct 2025 12:28:52 -0700
Sohil Mehta <sohil.mehta@intel.com> wrote:

> Thank you for taking a look at these patches.
> 
> On 10/30/2025 9:58 AM, Andy Lutomirski wrote:
> 
> > So I think all that's needed is to update "[PATCH v10 10/15] x86/vsyscall: Add vsyscall emulation for #GP" to check user_64bit_mode(regs) for the vsyscall case.  (As submitted, unless I missed something while composing the patches in my head, it's only checking user_mode(regs), and I think it's worth the single extra line of code to make the result a tiny bit more robust.)  
> 
> I probably don't understand all the nuances here. But, the goal of the
> check seems to ensure a 32-bit process running on a 64-bit kernel
> doesn't ever go through this vsyscall emulation code, right?

Do remember that there is no such thing as a '32-bit process'.
Changing to/from 'long mode' isn't privileged.
OTOH in 32-bit mode you can't generate an address above 4G.
(But I've no idea if the high register bits get cleared before the register
is modified.)

	David

> 
> I guess a user_64bit_mode(regs) check wouldn't harm. I'll add it when
> the vsyscall series is posted.
> 
> 
> 
> 
> 


