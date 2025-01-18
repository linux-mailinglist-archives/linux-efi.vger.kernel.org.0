Return-Path: <linux-efi+bounces-2662-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B9AA15C12
	for <lists+linux-efi@lfdr.de>; Sat, 18 Jan 2025 10:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C1F21883985
	for <lists+linux-efi@lfdr.de>; Sat, 18 Jan 2025 09:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A35F1632D3;
	Sat, 18 Jan 2025 09:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luMFIokJ"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2198B136352;
	Sat, 18 Jan 2025 09:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737191424; cv=none; b=E9+LLvaRpMwwY/b9W0IEePijvoekRrG+DP+EwXsMkDgI/KKeQWLYDrxdHEGJHm351ZChUtnVyaurnKXxD0nlqyXVoyHmyujvb/qssOWWqVD414nDWbItOrzNUB/Yf+rX6mXHyIXrAzLicvXGiwiTk7LxRrCbAnSoLKdXrlh9n1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737191424; c=relaxed/simple;
	bh=9UZCbwg//sXVKG/P6RkSmerFBPTQrbwQkWUuBN5cAb8=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=UX7n3dwQPCRhyOD7UChotHyRiqdrDQp5NwpSxoKXdz44dA4TfZliK7V5cOS9FvhPcGL8hLcCpO/eXsOBeUeS29K0sy/D8ZOJXwXJNKdkFly95qE7sXNcu76TwA2e5yPRfoy4VtB7lhq+29bOGSWvo/v1NdoiUh+FPv+OWtzVPM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luMFIokJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECF71C4CED1;
	Sat, 18 Jan 2025 09:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737191424;
	bh=9UZCbwg//sXVKG/P6RkSmerFBPTQrbwQkWUuBN5cAb8=;
	h=From:Date:Subject:To:Cc:From;
	b=luMFIokJkqtXMFlQl/dsK8uA8t4nbSPsKixJupeZvwmZH3un7QjNyT8YdhZWWXda0
	 O9BeUpLxLck/1gRU5LZuf1KA8zMQOgJwY6t06PGSXC1AmH8bCU+YL2Jy3nhZGPm1UC
	 EGrau6MtspkE4VjRHEOr4lFNTu/NW2ajGDIfaw3VfivOsnWQfNQr6xh+RU9RUfMbJ9
	 B+J6IvJcswzRjGtlh5aLRuQx5006X1fYg3vOOuLh9RP1w3n5pN8aHwoADreOP7Bs6T
	 nzNQMTgaS6KD9PWFq6u+DeajOjND3RATqBMvEZKC820r9Ji/t5QAiCZf70TGq2iKEG
	 okkWK4N9HYySg==
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3072f8dc069so12681331fa.3;
        Sat, 18 Jan 2025 01:10:23 -0800 (PST)
X-Gm-Message-State: AOJu0YxsHzSubwnKAkG1PIB2xKFZdLqqOlNHtB+UNEXw0Pd6TzSpFeNT
	ZSpy4lCOtrf5qLr/24fi4O4TXFjXCagaxAfAlxJOv4/gyRAeFDl8djHCfD2EBqjon7iGbsUq+6H
	Wasty2XEoI0xRqSAJsUbeuuaeCng=
X-Google-Smtp-Source: AGHT+IHzUnpZe/eTX1K2EI1AbRfx+Mjp+Na5XYYlcdjx4NCrrEtHBFVtWhzfC/30pYFeRQS0Qh9LD2kZpyjr6+IclNk=
X-Received: by 2002:a2e:a987:0:b0:302:4115:191 with SMTP id
 38308e7fff4ca-3072ca9c53fmr21668261fa.20.1737191422275; Sat, 18 Jan 2025
 01:10:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ard Biesheuvel <ardb@kernel.org>
Date: Sat, 18 Jan 2025 10:10:11 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFiGMeyQSMsYWuEgSnXVU4GfVC3JDLGhZ7L2=BEvxHVsQ@mail.gmail.com>
X-Gm-Features: AbW1kvZnJtRJieTkaKEPsPGoQwJktaDQWzv1kdP7nQpMtKZQAK9fJVud0SSQCRY
Message-ID: <CAMj1kXFiGMeyQSMsYWuEgSnXVU4GfVC3JDLGhZ7L2=BEvxHVsQ@mail.gmail.com>
Subject: backport request
To: "# 3.4.x" <stable@vger.kernel.org>
Cc: linux-efi <linux-efi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Please backport

0b2c29fb68f8bf3e87a9
efi/zboot: Limit compression options to GZIP and ZSTD

to v6.12. Future work on kexec and EFI zboot will only support those
compression methods, and currently, only Loongarch on Debian uses this
with a different compression method (XZ) and so now is the time to
make this change.

Thanks,
Ard.

