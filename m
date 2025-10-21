Return-Path: <linux-efi+bounces-5076-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 88647BF6DE2
	for <lists+linux-efi@lfdr.de>; Tue, 21 Oct 2025 15:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 582FC4E56C5
	for <lists+linux-efi@lfdr.de>; Tue, 21 Oct 2025 13:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5F533893D;
	Tue, 21 Oct 2025 13:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNJ7zmN1"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8B3B2494FF
	for <linux-efi@vger.kernel.org>; Tue, 21 Oct 2025 13:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761054490; cv=none; b=dh+ds4pMZVeUIU7IcrbfQdzuvUg0skHYbDFUPbfMnEFEQOJIXmZNdLbUhx6n78K6CkxnS+7fs+nde8UF3yhx+i+KHtQZI1F3e8XMIGUgo6lVn9Dz0Sp5e68G0aVJE3YTZKg5Da8HZ1gjQ4Oq3KVjcPyXDERbT0WTs2vaEWUFmQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761054490; c=relaxed/simple;
	bh=hWVpdQ4qzW3f4IwuZZhcoX4ShVzp4YZhPQ1LBXovShI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TRScq2JkjOirk+hesZ3itmPuE5abV8adL19SFJnjSMqGGp3SxTPqkoAmTjdIlEPnqtq7hAuWOcBSPQnxKwAXH5146d3cKlqmsck/2uwBTefG5SJ+nDCWm5xpKgY4mU2SIYMWK895X6VrNdzGiZCzRDhVVwWvCSIp+ol9BTj5QKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNJ7zmN1; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42701aa714aso3418406f8f.3
        for <linux-efi@vger.kernel.org>; Tue, 21 Oct 2025 06:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761054486; x=1761659286; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fDKI+uqj4/PiSrDUg7xaC6n35ZWBi8QY/gzE9TEB0ME=;
        b=YNJ7zmN17iHMQuFs/KTWcvDxIYJtnMzrERHM4ZNbU6kCmRvLKIV+JsStIVkOFNAb18
         EUI69Sl5onBFYOTYukm3PYYVPvJ20GHzV1FKTWCBQZTGGbwBKextq2keypg6MxvAv+QX
         /xqtV+ZiN0WuCMLMzhxyS5VT/ffVOto55LruF0miMLzgHlSTLTrRoXg6Ds18NtlTHmYA
         NhYUhcrs0kJ0ZQsmTSbiuNACrJgygH2MeSWmDkpelLWwcfxHqt+tLuHiB7lKgO+JuyMe
         Nv3Br0iCec68hZhBYpGWcKWt9SZITdSg790JOsWG/lD24jZP2eNmd3tpN6QSkoaQK6Ld
         jv7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761054486; x=1761659286;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fDKI+uqj4/PiSrDUg7xaC6n35ZWBi8QY/gzE9TEB0ME=;
        b=ZQiST2tqR4B9P+m8wbzIyrhidQ4Az233EZHdbyOUnnzVvrjWKqonUA2U0GWPLV/Pk0
         BGmxDbLjHrhV8M5EvYfulLyPG1P6mQSEcX0FbO8MsfxD/qcdFp2mAWbKGscZlkgRebtx
         DUTQxwe/h0I+ADmxtNkqV0j6Z0qXd3sEYb2vv+d/jWwQOFEwdsVsqTqpx/9lvPKVmJWg
         91zZuckkOEy0jhT+vJxhNMXis5lFZH+IJFZ2KXlXRA2gA4WDZMlWAis34EVid6KiNSk3
         FDCLLUm/0AUhmKBRMTjFUleUQyFb2yEQc0Lix3vkbfPz0g01lbz+Xs5k7rnM7Bu+Xeyk
         sxVw==
X-Forwarded-Encrypted: i=1; AJvYcCUrHhuL2Ja2fyvNvaoxH/qJHpgJToJs6Yly0EGHJrAYBTsrhTum+RgG5bx7sBmoKJ3DqTsqvW9y3J4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxO11ZaM0hRPc41ABjUvGPi/mfU1Q9cew9QlTo0QGq1+vFM7SF0
	aY1sA83nuzo8N3pP6DJEmvWtEgKs1T2GDMZln06EqbSsXcJ66afNrcxa
X-Gm-Gg: ASbGncsfcZSldPek+PBJ4cnNFTphjVe5JArWAP8nOZWLhgN+q5IN3+vSjs8xCPGGYJJ
	+53WYXd0nwr41EMnaji2Np8gRje4AsyewMN6FodRAfM2rfIuhEK080cTcGeuZ55A7c/fe31Soem
	+DscizxBm1JEiMlH//a4i+yMgMlvDq9BiDT/kUCbUB9cWkAvSMtE57PVS7cHLuNHK/qxQnzffvT
	a/UMmMLn/YMqbUYVKc9COwxE++6kcNa0phQpwKYom6ukNq3FthEDuMu2jwI8wBURgLvlfPT/62u
	nbDY/AfaihqThYW1xZ2GOUoXeluox3QXcmc1/t2sHbDamRLBBWInaFftmm3Gl/Mm1b8lC8D6fyJ
	ggVwkptb3th2gQOiUcqJJ67A2AHGmL85FKHTBs/s7dDof/+RyHy296pg5Ae/oIxNB/OFpuX1y//
	nMijG8f7dysaRq7XJAsK04LoopaGxULubZKNpChcftww==
X-Google-Smtp-Source: AGHT+IF6HCVp6aK0SgfW6hE72HLbI/KN18j5SeYFoFF6iWu0oTL02abLRhSo7ownBmlUpl0HSN4Z6A==
X-Received: by 2002:a05:6000:310b:b0:426:d80c:2759 with SMTP id ffacd0b85a97d-42704d610f8mr10968224f8f.25.1761054485851;
        Tue, 21 Oct 2025 06:48:05 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f009a781sm20879873f8f.30.2025.10.21.06.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 06:48:05 -0700 (PDT)
Date: Tue, 21 Oct 2025 14:48:03 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Borislav Petkov <bp@alien8.de>
Cc: Sohil Mehta <sohil.mehta@intel.com>, x86@kernel.org, Dave Hansen
 <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Jonathan Corbet <corbet@lwn.net>, "H . Peter
 Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Josh Poimboeuf
 <jpoimboe@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ard
 Biesheuvel <ardb@kernel.org>, "Kirill A . Shutemov" <kas@kernel.org>, Xin
 Li <xin@zytor.com>, David Woodhouse <dwmw@amazon.co.uk>, Sean
 Christopherson <seanjc@google.com>, Rick Edgecombe
 <rick.p.edgecombe@intel.com>, Vegard Nossum <vegard.nossum@oracle.com>,
 Andrew Cooper <andrew.cooper3@citrix.com>, Randy Dunlap
 <rdunlap@infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Kees
 Cook <kees@kernel.org>, Tony Luck <tony.luck@intel.com>, Alexander Shishkin
 <alexander.shishkin@linux.intel.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org
Subject: Re: [PATCH v10 02/15] x86/asm: Introduce inline memcpy and memset
Message-ID: <20251021144803.519e6244@pumpkin>
In-Reply-To: <20251021124751.GLaPeA9z8BCIe8AudC@fat_crate.local>
References: <20251007065119.148605-1-sohil.mehta@intel.com>
	<20251007065119.148605-3-sohil.mehta@intel.com>
	<20251021124751.GLaPeA9z8BCIe8AudC@fat_crate.local>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Oct 2025 14:47:51 +0200
Borislav Petkov <bp@alien8.de> wrote:

> On Mon, Oct 06, 2025 at 11:51:06PM -0700, Sohil Mehta wrote:
> > From: "Peter Zijlstra (Intel)" <peterz@infradead.org>
> > 
> > Provide inline memcpy and memset functions that can be used instead of
> > the GCC builtins when necessary. The immediate use case is for the text
> > poking functions to avoid the standard memcpy()/memset() calls within an
> > RFLAGS.AC=1 context.  
> 
> ... because objtool does not allow function calls with AC=1 because... see
> objtool/Documentation/objtool.txt, warning type 9, yadda yadda...
> 

But for the purpose of code patching they don't need to be 'rep movsb'.
An inline function with a C byte copy loop is fine - provided you do
something to stop gcc pessimising it.

Obvious options are a volatile pointer (or READ_ONCE()) or a barrier().

	David

