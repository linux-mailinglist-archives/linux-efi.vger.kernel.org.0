Return-Path: <linux-efi+bounces-1201-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6A190418E
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jun 2024 18:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D84231F2390C
	for <lists+linux-efi@lfdr.de>; Tue, 11 Jun 2024 16:50:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECB0440849;
	Tue, 11 Jun 2024 16:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cnU8d/l0"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5241B17721
	for <linux-efi@vger.kernel.org>; Tue, 11 Jun 2024 16:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718124595; cv=none; b=Sj5dwrMb9+I71JU1J4wvl8Y2jwFZCVH+JLqIlE9kNLhjZ4gS9zfwku9LboBQNr9rbq7k3xkVGyR3lwnoThj9qMxIzuYQ1A+7eIBonL6r9r2i5TI5J1HpHmyLGYBIko/Ctp4gOdqFyK/aIlqTBcV9gZCsg6UkTZEZh9U2vBdpWh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718124595; c=relaxed/simple;
	bh=IjdEw1C2tbFqMVPhNb/yl58BeFO0X6DS0+1Pn4xEARI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m9lSV5Zlp2RAKB6mz4Zbc5paZfC08u9vnNee9euY2QwilomMlGmCaluCHhSbCN0vig5C/dwUz4z7myTJPfHUUz/Bz2MlDNBEjZS8ePbCkeF5hNagBZ13Xl8rbvAwzt21vpkvafowE0Qvngg85szkR3sxyIKoFElbwRbF0XTQ8Ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cnU8d/l0; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-518948e1ec8so12e87.0
        for <linux-efi@vger.kernel.org>; Tue, 11 Jun 2024 09:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718124592; x=1718729392; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IjdEw1C2tbFqMVPhNb/yl58BeFO0X6DS0+1Pn4xEARI=;
        b=cnU8d/l0oYf3kZIPjosH778Ev5kBkl+nq9dEsWKk6JhD+rd+nwmzI+nDGHrcnItYHB
         QAPsCgclewO6TFCcuhgRiByHa8nWBtAY92LldJj0AXXtoEFFUxeSOtiSAxtIZcxbIQRS
         RASCndSN/91TCX7LfbskOjeLQezsnuqtna+rDq1MID2wCpk8qCXMxJCsihWjBvsFqbt+
         NoykMvDHzqmAqIJvMracOR71B93chkkADFeli9fqD7kDbqEY9+9spqYVVsDUT6lKQFrh
         jND88h+ZiE+AR49gWd6zD/jhopzQnTH6vzdwqyrj2Q2ds/QTgbYGpUsZlVoMVRnobDse
         FdJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718124592; x=1718729392;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IjdEw1C2tbFqMVPhNb/yl58BeFO0X6DS0+1Pn4xEARI=;
        b=cw+a1AbfeBGK4QuLu1XMirsbNAMrmER/U7/YLoIvLV4b60jDKxXzrMFVnzL+G6VH2Q
         1hyFMf0acG01XqCs9xJ4hmv5Q4ITUkRV8L59LhGxOj2QlnGtok0AT+LL9ViDHEDBUgD+
         yGMtSqV5f0H0nXjG2EeaPTRi5CAF0YeAsP8KsL9X3H43IgT34DosvI6BBOQVjvadPhG7
         rlCfom4fpW5+P6cCG2gkxpzaBITQMnh0KePlrQ/Otkc7Uom1EezKqO/az+TVAkO1wmnl
         r7GX50Q6TVaYBx+4EPmjfQr7LAFmXhXEH7KZkfjVsDPY+npSSJE+tp5/EsB97+9rh4Es
         AuhA==
X-Gm-Message-State: AOJu0Yyzt4reSO0MYdPFRpwDKv5ge6jZKUmpwSuSvLTPUKW0JQugZd61
	6jXwjRqGf7aHrQCAt4HnerLpIZHlJDu9FmBixJLEU3Cuwry+OxVTIt/2PJnGMHO/X5AoVzIQdGU
	UMwuStz3UH9e6R73/op1rvWQ/axJfIewR5LHi
X-Google-Smtp-Source: AGHT+IFwjOZxJZHkqLbTMDQCmFy5sdz2kFb/5DmXAbP9is/6Hi1MN5mczPas38dSli01mv+A5ZDfAx5xoDhGWTPQJdI=
X-Received: by 2002:a05:6512:3d86:b0:525:11fd:cc2a with SMTP id
 2adb3069b0e04-52c93d736d0mr193777e87.4.1718124592226; Tue, 11 Jun 2024
 09:49:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610215304.2953611-2-ardb+git@google.com>
In-Reply-To: <20240610215304.2953611-2-ardb+git@google.com>
From: Nicholas Bishop <nicholasbishop@google.com>
Date: Tue, 11 Jun 2024 12:49:40 -0400
Message-ID: <CAAzv751S4k2nCrSuF2+=y1pjHGDQaNLpu9LLZ+uVX-qc-2NarQ@mail.gmail.com>
Subject: Re: [PATCH] efi/x86: Clear BSS when entering in mixed mode via compat entrypoint
To: Ard Biesheuvel <ardb+git@google.com>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ard Biesheuvel <ardb@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Works for me, tested both my Compute Stick and VM.

Tested-by: Nicholas Bishop <nicholasbishop@google.com>

