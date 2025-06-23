Return-Path: <linux-efi+bounces-3919-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4014EAE4AFB
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jun 2025 18:31:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4500C1651CD
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jun 2025 16:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C292C26D4F7;
	Mon, 23 Jun 2025 16:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mrk9geb2"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E505266EE7;
	Mon, 23 Jun 2025 16:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750696227; cv=none; b=H/j4Z6rQGcaLZmVUmoEze/U46YPNb+yaqf3GE+umeurvi41dy6XvIOYwklzCw8LAKuDCZkL6Tr2xLM8ibVrmL6Iez4UMk7ovsbEzs5iBJkLcjKWD4laVdx40eSGdBdEFwmC1XNUoPcjakJX70fGd1+jajfV+qVU92uqdNiPcW9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750696227; c=relaxed/simple;
	bh=7ECXGsFUva9QNGfgrOK7NVROKgyu9NjU4V8G0ctTWa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uI4wpkcPPHdoxvQIL2BrqRc6txoPk4nd31+pOJVFfLv99VC2GSF05p8RNnqGE1n90rq83+9JkgXonk1MhEoQrLRbuCBvXyx8C+1WLp550VmmCfX2Tii934H7dWvCD74dNncdCd3V1Pw3HkxIQcLjboKo/K8YCFkPqLdCMb7WfVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mrk9geb2; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-3a5123c1533so2224775f8f.2;
        Mon, 23 Jun 2025 09:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750696221; x=1751301021; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/0pqYb3tUeSBl/lIRawvuaSAg/yO32TdfmjQOsmwU1A=;
        b=Mrk9geb26I492jESlDKfvsncZneNekxMJs/PzaHa+KS+OX6WB2Q+Az8NuEyzxr7Uke
         CLFzOGScWz60AATUFN/Z3dFUmHE/a5040uDo2X2w2FCYXLTs3oq2boFec4Go54ZkGh10
         MIRK0x6u0+p1AlR7pN5VXjdcIENjnj8H7vkEz3ygTRiJtW/RU6v1Idwc5+zc/noTjc1Z
         AG7pT6SmlKL/YK7uP+Tbe4rQEZiYbuqQ0qIaCDADyJZ8UVrpia2Oraz0b6xq038iQs+X
         xa4r59pRolo0xeG+Fge3+pUtI6TzaAzbRUZdSCEJT4eew94GIqkOJwPfk6//5c1rHSY9
         UL1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750696221; x=1751301021;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/0pqYb3tUeSBl/lIRawvuaSAg/yO32TdfmjQOsmwU1A=;
        b=DZQlz6TfQdryRQUEF+71JwZI5iEI8LOI2psEEHowwvMtqR9etF0WkQlgnCoHLY7rsp
         /d/838zybQiCUWUDNOzJTGbmHmovMDvArSHravU3bHyl+yuqQ7V/1BX4cAp/eTpEgVUF
         p7Xi2XvjlWadLVo6uPQDk3g60P0yDKCWBpY9y9UJmm5/aE7t4Vy8n/OrGDEhzEGSJbNi
         K5Tp6zRfiVt7tjD5/kK/i75rg61hZlTk54qtHyK3GItLdyuAoMlKQToR30aCYvytZTAg
         OUw6JC+yNdD9lexheHv9od6Tj9EG9FohVcv3KFmVAsJhd3nvMwlA8kozuTnBMCG/GgeH
         9ttQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3LydlZ7Dl5nprVPrBNevA5E9soFeyNatVeiyD+NJbLpvSGiDdVDImO8C6mnOUtX6bLSi3+07scjY=@vger.kernel.org, AJvYcCUTAlY1N/JJeqWiFz8d8Yd3ap/jPLe897i4iVbqwEtnnFG7iE16MpqRJUlHjygdNk76Kp6j39UmMk4ge9Ul@vger.kernel.org
X-Gm-Message-State: AOJu0YzjJFKSnry90RQ2s0y7a5iZ1KbuZ7nSL/3ftdb7pJDcXGrPqkqH
	b9dHcxt3dGOATAA8wKTVPARA54FLKXGfM0z3h3qjtWa1XW2VhjV2+w6j
X-Gm-Gg: ASbGncviM/vyvFoCxQkS+0LRdKRMxnjiJgRcu+ggx/GN6CGrAFym/J0M2NEMY+4vzPl
	TwSaai4B30BlseV08zTfNFnYHcYX9oVW0JsRao+MjFDz0QNn5s4o+9Sp367K9LfUyGyydGn5TdD
	N/YEdw+WN5Fg7vaMvcozf3oy6WXXp6KbjhinCClizg2JCsi88UgTKKFPOoizvBZMwJHPP7vY8YU
	Hz58ytWUpZdOB9Gq18VRgRnoEPfgV76XJPUPlyK5CDeWrGBu7zcJIFc8hTet25veAV/eFg57sNX
	SeDPQxKcT3SVnncVTEBDB00QBJu6Thjm0vROA4pPswPYtazCj8LZa9fG8AyphgNJiTAVGxEaDzO
	u
X-Google-Smtp-Source: AGHT+IH3+aFym5Y1PuEfzW1Qu45WJVQwDF74ldMdWRBk4mcrR7j5xDv/KzXcBPxdWgZvfinY+6Vyzw==
X-Received: by 2002:a05:6000:25f2:b0:3a4:f024:6717 with SMTP id ffacd0b85a97d-3a6d12e652bmr10478510f8f.53.1750696221241;
        Mon, 23 Jun 2025 09:30:21 -0700 (PDT)
Received: from localhost.localdomain ([41.79.198.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45364708297sm116967885e9.35.2025.06.23.09.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 09:30:20 -0700 (PDT)
From: Khalid Ali <khaliidcaliy@gmail.com>
X-Google-Original-From: Khalid Ali <khaliidcaliy@gmail.com
To: brgerst@gmail.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	ubizjak@gmail.com
Cc: x86@kernel.org,
	hpa@zytor.com,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] x86/boot: Supply boot_param in rdi instead of rsi from startup_64()
Date: Mon, 23 Jun 2025 16:29:34 +0000
Message-ID: <20250623162935.681-1-khaliidcaliy@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <CAMzpN2jBOW3PVJQLvua=knQNu_1mZ6RZYi8JvNenFd5t30UC1Q@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This was never intended to conform to the C ABI, why is it necessary
> to change it?

Technically speaking, you are right, however that doesn't mean we can put something where
ever we like. We came from C code which is bootloader and we end up to C code, so we should 
comply the ABI here too.

> Also, you cannot break this up into three patches.  Every patch must
> be fully functional so that git bisect will work.

Thanks for the tip. I will do next time.

