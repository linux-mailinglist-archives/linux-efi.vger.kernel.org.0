Return-Path: <linux-efi+bounces-2508-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D345CA0301C
	for <lists+linux-efi@lfdr.de>; Mon,  6 Jan 2025 20:03:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B8643A2619
	for <lists+linux-efi@lfdr.de>; Mon,  6 Jan 2025 19:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102EAAD24;
	Mon,  6 Jan 2025 19:03:04 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C99FBF6;
	Mon,  6 Jan 2025 19:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736190184; cv=none; b=r39gqLiK7vIi41DVbKEcsROPJsucQAtHx2F6K2wkuDR1/r4z9zqvVvdrQ+E1IuTJm0Aw7GOzW5YruexaVtLZmoLi87zTM7R/AwC5WePkcpX53s0+m5DNDHfpGXVFJ0SLRKjNVuWNlN2Bbqg4+98UiYiY4KLsNIFnDzPEOsw/7HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736190184; c=relaxed/simple;
	bh=Kaun2XjQcGqhzdwfUnkMMyGC1AiD2sat5V8rYb8U8cw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=QofExGHVqHYnbJs6+pTWQxtuSi2b9k6JTbd5boH2di19GhNQzecXiBtYHUti40kjn4p1aFF/Od//PIThcO4tiscIO/21AxEXvJlolEEC+MIn7LTBgP/RzrfEow8HClivEqnzFVGoMKISGvThOvfwO1TEgVknRf+KRMmcomSJwuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5d3f28a4fccso23396525a12.2;
        Mon, 06 Jan 2025 11:03:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736190180; x=1736794980;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6qNhJ1zft8sno13WbTWkqhMT68/uGe7LglCUiwLVtfU=;
        b=aS+eVSXwKUavZLMs4Y+zGA2kyX0WrqqIQPVhmdVGeroNOdN0QRkB65IW8stux6qzFq
         DmMHjedtSoMmaqiXtOHEhV5LjH1Nhg9lpAIV4kK9OS5VXFop99Qh7ola+u2DJ1JrCDEo
         zUHLd9A5a3ft1/DDM+MRztQZtpSpEqu7/mzt5+y3sJdoqvAuFjv2B7CU7rFub9ssdeP+
         dYcOW/chOLIa9Npk+s8+c1rpNvoEos6ZK11t+r0zNMYDAu3/NU0B1JuqGqoa5E5QMEDV
         7+Xe2UuGEgublLX7t2JArQ/GYkGN5rKLO5EfrmgRzwSOnoof5NAULX8prah5/xI79B4B
         2DQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVlEYEDmS+Vhh/DlTI3YRpqzObMs/dw43ggTFwAGrPN0HGsgukzkj2jezAc/RxQhHdMZkEJp+HDhaY=@vger.kernel.org, AJvYcCWGcVxE0ubBB9Jq5CNg7R3PuzBP83kcu+3AvVLSVPguD3Qai0yxKsqnh3TQFiKRolyNAL4lcMWWsud9VwEn@vger.kernel.org
X-Gm-Message-State: AOJu0YzVcPmKtdnfwzDJWWmTZFOSwqcKcYM4GTlE8Lj6luurKlA1CRdR
	/pAFgzMxgyLUkDEMu1QRXEZ3unNubRHsBtAK2JLS7Sd27D8ZWArF/jBGzQ==
X-Gm-Gg: ASbGncv7BSmmy8gxsSFkFYde1gVdehz90dzUHuFoX//0GZz/ZPPN3z9yIzvmpY1Gb02
	MLrKR0QYpJixG7AQKWDziYuR+M9p8N1fP4YccYRfwhuSVwHJwZUMfF0Wk27z6YrKFRkXuXdCBM8
	GYygZ3F3MZEG0SqxWtRWDYUD3TcvJu03ZO+5u+h8ihpRC8g0rD5ZHzqS6xH27H0+WJheBsU2d6S
	ppL0P0U4RA24on6gxDHbSVmOKr77MCq15QO48184GlT342g
X-Google-Smtp-Source: AGHT+IER5syycIY1WmwuwZdCNh9Tv3i8fC81I/fw3iG07o6dSFSwA+8PUpTxZQ06nMLcjHgDDIFMqg==
X-Received: by 2002:a17:906:6a1c:b0:aa6:88ae:22a with SMTP id a640c23a62f3a-aac34650b1amr4790270866b.37.1736190179994;
        Mon, 06 Jan 2025 11:02:59 -0800 (PST)
Received: from localhost ([2a03:2880:30ff:74::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0eae74e4sm2274599666b.91.2025.01.06.11.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2025 11:02:59 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Subject: [PATCH 0/3] efi/memattr: Improve the efi_memattr_init function.
Date: Mon, 06 Jan 2025 11:02:49 -0800
Message-Id: <20250106-efi_fw_bug-v1-0-01a8eb40bfeb@debian.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANoofGcC/x3MWwqAIBAF0K0M9ztBpSLdSoT0GGt+KpQeEO096
 CzgPMichDM8PUh8SpZthSdTEMalX2dWMsETrLaVNrpWHCXEKwzHrOxQW3Z9aRrnUBD2xFHuP2u
 79/0AATn8F1wAAAA=
X-Change-ID: 20250106-efi_fw_bug-2b62e9a41899
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Gregory Price <gourry@gourry.net>, Usama Arif <usamaarif642@gmail.com>, 
 linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1081; i=leitao@debian.org;
 h=from:subject:message-id; bh=Kaun2XjQcGqhzdwfUnkMMyGC1AiD2sat5V8rYb8U8cw=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBnfCjim1m5pcj7w4GkathuoF6RCtdQlN+zf7OmA
 NuSj+Z4MeaJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCZ3wo4gAKCRA1o5Of/Hh3
 bfn6EACd4dP275uMaURYkHOlSxvQTzceTqMNPNNljOKcNPQ1sXCiaFbs71+0yKh75L4CiLazGqt
 SWBHKAF+Piwdnf7R3VJiEfqOCW3znhn0wI/ZnHqMDOWu636uaiLhK9h7SXEVNGaBf76RBt72lZX
 jo8WxlLPwGM/eTanguXTJ2GEWMnLXGkCiQE2M4CoYm4r1BE61BukSG9IoPlp55u73ddNdT5Oq+R
 WBWlG4SLNTq3iuPZ4UWvrqr+thuMpW97hqxtt0lDloRPCjjZSQNlSsjCfocGOJDruhm4sxiGWKu
 GCiQ26UO5sdSbnNmln4zzGXABVPHGdyyDcZMYyvKhRRo6Ltzos1mQKxFZSW6vwlJCbV7ow2/6NI
 ikLbfFODeACpgpdy7+86aOd9t6qgxWxMI9xpHD77e++okYqf7SHNFVbLPIGQAnUD2EVITjxyioo
 5XI1XFSWjlVKBBvYxOG3wI6OmUd+EXCyMgZFQEvNI8zyfFiQmf0i4DSHXFfR/RSrA8a7xfqOr+K
 BvtljHx2rhVw+EC0ivXGNn4aosNJuTVx03/07HN49Vp60kA+oYHh2siXTb5Tb/uqvNl30Vf1+kG
 MikJn3LjsstaxkWjQOe5ZLxboSSYmiJftt8j6f32gt/yk3on3evB1g0vLQ7Ud5+kCkMIZ2/GmvO
 VabuYUoi0GMql5g==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

After 8fbe4c49c0ccac ("efi/memattr: Ignore table if the size is clearly
bogus") landed, we are seeing a lot of firmware bugs in the Meta fleet.

There is an indication that this might be related to kexec, but, more on
this later.

While debugging the current issue, I modified the efi_memattr_init()
function in a way that I think it might be useful upstream.

The changes will help to detect EFI problems at scale, by making it more
verbose and easy to categorize early FW bugs.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
Breno Leitao (3):
      efi/memattr: Convert efi_memattr_init() return type to void
      efi/memattr: Add FW_BUG prefix to firmware error messages
      efi/memattr: Include EFI memmap size in corruption warnings

 drivers/firmware/efi/memattr.c | 20 ++++++++++----------
 include/linux/efi.h            |  2 +-
 2 files changed, 11 insertions(+), 11 deletions(-)
---
base-commit: c8e17339185951589d109ba81e8854513ab3d26f
change-id: 20250106-efi_fw_bug-2b62e9a41899

Best regards,
-- 
Breno Leitao <leitao@debian.org>


