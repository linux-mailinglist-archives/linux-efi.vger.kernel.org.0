Return-Path: <linux-efi+bounces-3924-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 797B7AE4CEA
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jun 2025 20:40:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D9D9317AB11
	for <lists+linux-efi@lfdr.de>; Mon, 23 Jun 2025 18:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446FA2BDC35;
	Mon, 23 Jun 2025 18:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDg3+VKB"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C117278767;
	Mon, 23 Jun 2025 18:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750704006; cv=none; b=bvhnhVKJI+ggkIQmf7zY7NfdlWz/iJrTwR12HPGbquauGIDB10zJf4glIW0S36MopDxeeDtoY78xdVMwiQ3y6TY0WKlaL+JR0RDFwlQX3VUXYMFeqPWjXPgudZmeyy6KJ9zOZwF3JVoyjEjpHsqSvoc7V0Ty2m5R2qeONSu132c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750704006; c=relaxed/simple;
	bh=eVrPEmcrHl4/MMuHLudga4hdYcaxgR8DjuRMTBR9iUA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BCCM2GqFcXo40Z4a+OXw56JV4tdp9CwUPFCKXaxhueV8QauM7FpA0wcyKktAjqR6OgxJb1MVDHg2zlsvGvA1EZh8U++/jT/I5maBnF9evMcuLoWkzFAgloH7WLTbxUao39C5V4L+nGTMtZyM0aWzaLKCLhWOnEgOXxTV8AyJgK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDg3+VKB; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-451d3f72391so41855345e9.3;
        Mon, 23 Jun 2025 11:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750704003; x=1751308803; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t6R26MCj7pvOWj3CHqnMWClP+73cmGMT7ZJSALTSSME=;
        b=mDg3+VKBVUOgwFLREZsctRL0eFvRu7L9FrZsL6sbRhisk9Kl4rvY/GxukmkV331JF5
         lru3dIAWMIcPa1cll0dqkeBCoZNib0SP/OQYqLAqfJh8ir6CmP2GsRVgVgR6gIYi/jGR
         IKak3otK6S5bNbsdJ423JLwvXzp8EMdSlgD9sohSkjpNCXmm38g0g3oPcdehJAuf7ake
         +o2oVFit4AA/9U2RgGjslE89ibeVNy1KqCjLjySRkK3GUop3dTlBvUqE5ThQ26sKt/e/
         b1KswPL8PEU1R2uuH4gmI2dNBuUekud8eTXm0AyzdBtABWcyiJnfBim15TSEggKbDGRw
         j/tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750704003; x=1751308803;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t6R26MCj7pvOWj3CHqnMWClP+73cmGMT7ZJSALTSSME=;
        b=IKF8uT+IY0cnycvDaZ/QDExtNoqIHlJ6NqVSxOWvzA0zJxIiSYYQwRY3BckljZMLwF
         oKfOiuC8SgYf6AfbZbDHJ3ELzLwD/Xt1RIIGv1TE7UBxyzsPM2fpMmcVcH+2waaTPERG
         KC82LL41aaH1MyvtAE0jyYkbDJYoW4e3aQMVouf84nBnO5QVEErwlPEC2fWbS1Twf5f3
         pw4UzJbcEG3khdhLuGuiEAPxoKOJlaYhtfn/+Y3JqzdQUIK1UJb+ZbZL2aAF4xe6G6f7
         0CokwyRVt2TYpEVhqRMEZ9aST6xL1t2iqsDE5I2G4lzIAMa9SD90GmuoR9p9oQG0ErcR
         bQqw==
X-Forwarded-Encrypted: i=1; AJvYcCVq0HqGSycEcUneTNseViOtzU6XkupRlXq7fbhRqgwERs+SfkqcsdWEfnjwAavWsjSDQlDTGHm5R+wfdcXl@vger.kernel.org, AJvYcCXu9wueJnxZQyP+6ys9pS65WLxamw2a0glGF0ufkeqgUIwGLN3WwdGlf3Npb6XpBDeuqD/jsooDmoI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvRXvKrSixpl/HrvkBwJb+RL3UWsT0ijcudXfBPhRzCN0bcuS9
	v9LdQ9whMn54ijgd7IYd4qdNFDDw5czp3CdhrNQ5WcE22WpJ1e6dFmUv
X-Gm-Gg: ASbGnctUfk8SNd+bRL4NkVcXBJxU5OsC9cH1cuhBEyZjRT7vKLptcEkvgPcCrcw1ur7
	71twRt7+o8Cab50sH7QivmJUz+RfTDlM96jUqkE6ZiSfD6Bo7fcgR3LBzKMg60z5+vMnLqINg+H
	r7ZYgrGZqPVr4jbGgXyrWLEvwcnxD4ICLyuC6h1mfavSMABu3TKMCcOIN5Xba1yvKZxidXBb4ty
	2XlpHMemsYTKteeMhtvIprEg4Zw/QSarhmsTaFJh5kYrsIow7Z5bybk6cidE+w5j5SVZqwi5MzF
	bBhRzREeDjiY6VVu5jXOW2Jc4cA7sGdjww+1bsVprZYMYA1xN/ODypeZJwJ25pOwoSWzYTIUILy
	Q3uC9hNui+d8=
X-Google-Smtp-Source: AGHT+IGiWYBiuPW0mey+8HgyNPcVTEK1DKPZxVRjXFcoKbsJ/V1UmHmWfnybdwSBifzAM+uSzUYdFA==
X-Received: by 2002:a05:600c:4510:b0:43d:45a:8fc1 with SMTP id 5b1f17b1804b1-453659c484bmr125065645e9.4.1750704002483;
        Mon, 23 Jun 2025 11:40:02 -0700 (PDT)
Received: from localhost.localdomain ([41.79.198.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535ef6edbesm150258235e9.20.2025.06.23.11.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 11:40:02 -0700 (PDT)
From: Khalid Ali <khaliidcaliy@gmail.com>
X-Google-Original-From: Khalid Ali <khaliidcaliy@gmail.com
To: hpa@zytor.com,
	brgerst@gmail.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	ubizjak@gmail.com
Cc: x86@kernel.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] x86/boot: Supply boot_param in rdi instead of rsi from startup_64()
Date: Mon, 23 Jun 2025 18:39:09 +0000
Message-ID: <20250623183917.13132-1-khaliidcaliy@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <860684c8-a985-47bc-af30-3370f203e80d@zytor.com>
References: 
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This is also invoked by some external bootloaders that boot the ELF 
> image directly, even though this is strongly discouraged.
>
> Therefore this patchset is NAKed with extreme prejudice.

Thanks both of you peter and brian,

however, the boot protocol document saying "%rsi must hold the base address of the struct boot_params",
it doesn't mention why. Maybe the document needs update to justify the reasons. I wouldn't have known it 
if you didn't tell me, so this shouldn't confuse anyone else.

Thanks 
Khalid Ali

