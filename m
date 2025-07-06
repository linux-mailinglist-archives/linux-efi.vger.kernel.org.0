Return-Path: <linux-efi+bounces-4138-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D00AFA45A
	for <lists+linux-efi@lfdr.de>; Sun,  6 Jul 2025 12:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B036C3ACAF4
	for <lists+linux-efi@lfdr.de>; Sun,  6 Jul 2025 10:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9631FCFF8;
	Sun,  6 Jul 2025 10:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S+HgeWJy"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1251F5847;
	Sun,  6 Jul 2025 10:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751796603; cv=none; b=V94SETD4TmJoHfqBx3vABTpxSQ3lPtqzWaCIKCNiUZ44X5w0ryra7imlVbmGxMbzI5ipsQO25TqEpedrhhwb0C5Yf9QY+sAn1DpFGGEBoIAnKTAbTEpgIIAdA1kBcGnodu02rqp2VJpCRISQ4NFACZ/wgM9jxCLrLU1mykZUMkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751796603; c=relaxed/simple;
	bh=jV5hk2L/22TCKsTCyR4AWVhsz/bZszE20n4bChKlIP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MAfwwXfrPwFyrL2MzP9/6w/FhbRYWX6XcQ2tqAVKwzlRzMA50V9DukrfM0mqUJYpFfc6RkbaoigQPblhgiXo4+5xKBkaZ2Uge91oCdi5fsKcXciFmyfPMBIUdSdR9NkqMWZz7OEAIBo5lO3ly4yAHgzDkmANow8bavA6bxku4/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S+HgeWJy; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-450cfb79177so11744655e9.0;
        Sun, 06 Jul 2025 03:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751796600; x=1752401400; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jV5hk2L/22TCKsTCyR4AWVhsz/bZszE20n4bChKlIP8=;
        b=S+HgeWJy1e75+KWEjW6SRfRYAIDcC4fNmVTfd0O3W5dZR33UWdser3JgPgOq97Tneq
         /c3EfaVryD9l6/NeoI0EMhCG0g1tBobIo7oYaNtw2bEFwTeJAzlyKW0q6qrTnVgpdI1b
         dhM2UYvEWT2DlmQMumCdWJ3GDzRriTxTopeDP7xiGPtS0QAaGXtJgiqLURxkfhXq/GJa
         2wvSzSd8cdM3m25FxhH+xsnONmwiAykwYaUiv8SMl5g6dEIf0mp/7MLbWmcmF+pixzSR
         8wNDOmnvl2VjZIfmyHod8YdFDXyyXjtVSf5tTQxel72KlE4gItKjYZzDYnbmF49M2RXQ
         Hceg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751796600; x=1752401400;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jV5hk2L/22TCKsTCyR4AWVhsz/bZszE20n4bChKlIP8=;
        b=sQoHNAFsNUTklITKm1uImpTfyX0ifOOHTZ37E1PFaFsvTwl04d7OPSbEP/YLTop5/B
         0/00b7bNSWitI06ka/sMGY0A01PI5otxJuESx0fWKs3U33ejaXJ0c1KFpPgA/kbqgUf1
         JhkdvybNYX5RUI+hFXgAGjhUAPZ67+/XoEEUbg5QE5pfPQ8ltvzq0BVPZzfN/TqN3svC
         VTc0rbiqeEDN+hcGGrPJaM8zPIRfDcJ+x3LXfizjVbnKDxbL62llvYM4SDI3AuO0NsAn
         QuWhoUVXFAFzFVtcjx/1eLr1rslvTs/M6hxapEqpjlSUopKaCOdK0Ufl7ZxtkLzWEoZL
         v47w==
X-Forwarded-Encrypted: i=1; AJvYcCUsmGy1oeOeEjsndHhu8jB189pQZr81AFjagk+rmyJNAwvtRxKGCZCaMBPKzKjNTW6lvMD2iZ5AWSc=@vger.kernel.org, AJvYcCXYRQKoFFtN/7/5zEIMWNiHuGcGVl8wR8H8TwDiflluoKg4F6kkS3kgjgFkqVR94Uv+6vQpTA3nqGxQftQF@vger.kernel.org
X-Gm-Message-State: AOJu0YwgYPV7N4/10buWFvsGnyoin5vzGn3zW40/PT9EX4BOiD4CqB0I
	Q+yEql913Ricr44yxjyH/C534+iaE3D/K4LGjzoFaqYEoWap3FI+2YET
X-Gm-Gg: ASbGnctSUVjs/ZTCby/G6cGpKifPG1iUjftxE4oOfgesKT/Juy5a4+Gn5aS6Bl050yI
	Sm2L1LO8aTIl1sz5YeRQTGS8ghUfZfqyXrfWp+RQtiK0koqkJkWDEIZLGTfheNKazSp05Ou23nI
	m0nVlZTt9RrLux8vp+Lefuu8URRl+o0HBS3RCLSu7dfuPMBgd/WAXp8d6h65S1xgwYwLCFVaY8k
	RBjmE3RvljuLHrBdHATetQ3Ucb4XPDviP0i+y4i2HKE1tcPT+qlU6Cf1qtN9pCtBgN7x0BQQ7Me
	tSQwIIzO0gDlqRat5ueCqdbXh2+lmEifqS5RSQuHOv/LeKbTUfCXG5f7WTAhgIx22I0R51Lr4O/
	+FQ==
X-Google-Smtp-Source: AGHT+IFboTpFzUmPBMceP5BQaZY52z0uD8klP61U5hlGg3Max/z1jvvjdVEPb6BxDr0QhRSMuQVpDw==
X-Received: by 2002:a05:600c:4f16:b0:450:d367:c385 with SMTP id 5b1f17b1804b1-454c576aacfmr1072985e9.16.1751796600196;
        Sun, 06 Jul 2025 03:10:00 -0700 (PDT)
Received: from localhost.localdomain ([41.79.198.24])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a9be0bacsm105336185e9.32.2025.07.06.03.09.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jul 2025 03:09:59 -0700 (PDT)
From: Khalid Ali <khaliidcaliy@gmail.com>
X-Google-Original-From: Khalid Ali <khaliidcaliy@gmail.com
To: ardb@kernel.org,
	paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr
Cc: gargaditya08@live.com,
	jonathan@marek.ca,
	kees@kernel.org,
	linux-efi@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	lukas@wunner.de,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] efi/libstub: Print uefi status code on error messages
Date: Sun,  6 Jul 2025 10:08:44 +0000
Message-ID: <20250706100900.1481-1-khaliidcaliy@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250706094354.1282-1-khaliidcaliy@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sorry, i accidentally sent this twice and broke the email thread.

