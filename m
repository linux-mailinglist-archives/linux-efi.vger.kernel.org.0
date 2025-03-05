Return-Path: <linux-efi+bounces-2898-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EF7EDA502AC
	for <lists+linux-efi@lfdr.de>; Wed,  5 Mar 2025 15:50:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 064C81892FAE
	for <lists+linux-efi@lfdr.de>; Wed,  5 Mar 2025 14:45:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C9024E4C4;
	Wed,  5 Mar 2025 14:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="GpPv39p7"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-il1-f170.google.com (mail-il1-f170.google.com [209.85.166.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF0724A067
	for <linux-efi@vger.kernel.org>; Wed,  5 Mar 2025 14:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741185930; cv=none; b=nhTzgE+G2U+go1sXa2o65ycv7uJXWonbtkTSjkRNpZHRLZrP6LiSmlDGaxFyG98r+r02tTdKwQtH/6JsYaP10gua7iYBmKDhI0LQkhOoMWzSXYiuiPEQAv7yJn6ZYocbwWD7/OairUPu4vMmNTmyMOEjj9iNBFiYIm0vsQztQAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741185930; c=relaxed/simple;
	bh=Cmk1xtK9zj/mZKksRgzAj6pkbkT0aOMNt6bwRChxyTg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=X0PET4IZNa2t2Z7n+7uQkfHZYmgVVBU7C0RNuKi3ubFPc4vhfeKuX8ZAc5fltLg8T0fvNde1MnwGg4ZW99omzJlKYkCdNdRDzT0L3uZolC8JZDByqpjvIfkBHCvMD8Z+o+yQUFACEraMoIdZEGkgu/tsBf6ozPFN+A7AT1OgGu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=GpPv39p7; arc=none smtp.client-ip=209.85.166.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f170.google.com with SMTP id e9e14a558f8ab-3cfc79a8a95so22684625ab.2
        for <linux-efi@vger.kernel.org>; Wed, 05 Mar 2025 06:45:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1741185928; x=1741790728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/mtFeKx17Yutqyl4iJJ9qPun4qwlSidhHSO6yuTK2pU=;
        b=GpPv39p7F0jzsUxYCnv0nOJcQ9gfdwlfXpTmD4Q567NUXMLjqYXSHZIUnRQFlgwJAl
         rRUpaVegoC5lloIXI1KkLJvkMWE9yaW7tWspFYimbzhXuDVD6ZvgQRuBZgxB/kdOvsDh
         rpRj6aZawoHM2CQzhk8tHGFVfODLP8scexxh5HWBS3ejchXwQzg+bfW1QYJ42vEdApQ4
         Rdxn5hwPf2AFWaMTwx0sGJevA6ZfD2bXABUz8AwXQe/KHzP9UGO558mCjIK0kElq8AM0
         p8CXXGFAnaBNnumJ3qrr2QvA9crMfUKteDhIj4qqInFcr2Bav935LFr0FykJqFDCOQ8P
         bXiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741185928; x=1741790728;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/mtFeKx17Yutqyl4iJJ9qPun4qwlSidhHSO6yuTK2pU=;
        b=PHAxdmmK+4ldIWP/X9ejdauf397Sjr46wYDte4NXz9C/WUQYS5oyXBhM+5n5/Qly4b
         GIrvUxpJ4tqU+5Q77p2P0ZF5Q8e504UIlHCVK85UxdoRYEQa31wKmDK/kizGtxmV4L8f
         RVUy0zUABDBS9S0FM5BJ08YjRg6eVgP2H9OSDlMyNgzkPnqrJ0Rt+be0dUhXlwhLqZiz
         3pJM1st6pqs3VDHAaA7javjUL9ZaKE8KV4HxS02TQ3wIejkRgcX5xbi/LkaIWBUVbOx4
         ElGDgl3JjF7J5qwokORLuuuQVsXuzMVlmufXkWZFkP6EujD6HQQM6s0whhINFqn/wnY2
         vuzw==
X-Gm-Message-State: AOJu0YxcouXcJNkHKX8+4ynggfywtx926ULWnX9LecTqJgXQD2q03RVV
	61kNiz8GBLLT6Y78k4uy8hfh85f4efcnQamPsnrTgYlnEGICvyvPvgbeXjuavEs=
X-Gm-Gg: ASbGncthPJvBPS2/EHvvC43ztqcKaVf0jjOoGKCa2gyBmFU4ujjB+7HoWURQSUDfFAM
	obI7H1K/QUKGgQbmvAZXg5D7E5JDGxXPqdIuFx8B2okRIxnkhpl+QRtwYQGV2AUIU0tXplGBbMK
	vbWhWj2SvYHJDt+aghLbfBZRD7NMivhuxqIxP2CJ++naHtDeXEqFisez5b3wR2cYDErizrckc+Q
	fX6pstbRboElGz6i2WGZT9jiyjFwFaBXhWAmRAlBpJ0O7my+uP6pgbqMAGu41tgrcy2F/11T63Z
	pNCOrXTYy+cVd9XjMxAtAbtjOb9ha2TLZo0=
X-Google-Smtp-Source: AGHT+IGsBmYSs3QMp0F/1K4jts+fZHuzb1nFpuhkf3zgDvndXF+r7uxykpB9Nima3gyrxwD3OUT9Eg==
X-Received: by 2002:a05:6e02:18cb:b0:3d3:dcb8:1bf1 with SMTP id e9e14a558f8ab-3d42b87f6bbmr41882915ab.3.1741185928232;
        Wed, 05 Mar 2025 06:45:28 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4f061c07b73sm3585381173.23.2025.03.05.06.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 06:45:27 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Cc: linux-efi@vger.kernel.org, Olivier Gayot <olivier.gayot@canonical.com>, 
 Mulhern <amulhern@redhat.com>, Davidlohr Bueso <dave@stgolabs.net>, 
 stable@vger.kernel.org
In-Reply-To: <20250305022154.3903128-1-ming.lei@redhat.com>
References: <20250305022154.3903128-1-ming.lei@redhat.com>
Subject: Re: [PATCH V3] block: fix conversion of GPT partition name to
 7-bit
Message-Id: <174118592720.8596.17751872254586866019.b4-ty@kernel.dk>
Date: Wed, 05 Mar 2025 07:45:27 -0700
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-94c79


On Wed, 05 Mar 2025 10:21:54 +0800, Ming Lei wrote:
> The utf16_le_to_7bit function claims to, naively, convert a UTF-16
> string to a 7-bit ASCII string. By naively, we mean that it:
>  * drops the first byte of every character in the original UTF-16 string
>  * checks if all characters are printable, and otherwise replaces them
>    by exclamation mark "!".
> 
> This means that theoretically, all characters outside the 7-bit ASCII
> range should be replaced by another character. Examples:
> 
> [...]

Applied, thanks!

[1/1] block: fix conversion of GPT partition name to 7-bit
      (no commit info)

Best regards,
-- 
Jens Axboe




