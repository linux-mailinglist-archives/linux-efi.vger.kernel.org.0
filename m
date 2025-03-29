Return-Path: <linux-efi+bounces-3126-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7084A757B9
	for <lists+linux-efi@lfdr.de>; Sat, 29 Mar 2025 20:44:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A27216A0D9
	for <lists+linux-efi@lfdr.de>; Sat, 29 Mar 2025 19:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4D3B73477;
	Sat, 29 Mar 2025 19:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="QRbjG9bH"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9281A1F956
	for <linux-efi@vger.kernel.org>; Sat, 29 Mar 2025 19:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743277481; cv=none; b=H/vwrgwhS6UHwV4ZSpJ/axoBJEnIc+M6Sh/RHg+t9myHtnLCEQ4cbBUOReVPUl1hvUJEyPcLHGcD57+sJD4kJfld685zYW/MGvapsk41/ZUBojq9EvjkNQmcw7WlQYHkAd4BLhdg3pYt7mVrw5Sow4RY2TPRk8UC3FdK5hyuJnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743277481; c=relaxed/simple;
	bh=RT5OX8g7HPtKKZFZF5a0eFLKVyie8ujRGnAfNUXmcW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OS+mE6lIzkInrnl6M9cAIioJg+fMHLIwt6C7mTbZMGph2u5IxI7WZ6MWWrQ954pjIDANf9Qfb35Q6EPnBNHnY4JHw8zVtQRPK7GznxmjYL5ggbDtcqnXrztNWEVpgc5xG0c021aPD1KdMAuyL0GsqBC75NKXQ2sBiAHzQBo9QhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=QRbjG9bH; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5e5bc066283so5226304a12.0
        for <linux-efi@vger.kernel.org>; Sat, 29 Mar 2025 12:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1743277477; x=1743882277; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0YWktOl964BkQDF0laCpxMDbU6R3mjFxj+tWqQowN7w=;
        b=QRbjG9bHuxnKJI0QW1F0yPl8MNZt4hxXSaWErtGvFTS3MO848h+ZZ4XYoX2WzB2QPg
         2KArv1jrEYNXcarweOmP/9TjVDrZ9rJnYAbdOyF6buyG+kBABS8ENq9I1AVuksfMn+e/
         ik7+MhvzDRxLzgAdz+Apik8q00HfQX9BgsbVo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743277477; x=1743882277;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0YWktOl964BkQDF0laCpxMDbU6R3mjFxj+tWqQowN7w=;
        b=pB9yjODSLAwoNjoSnBxCsUl3t9P4kZp2ZnUudcHtq3hiuAWcz/K018IcmRt/vNXzCo
         QadC3hJmXMgT2nQHM1DlcrBvW6hAjKDe1c1ZH1s2gRp49MKXzskKrVdc84aqYIRezD2V
         0Frn9n3LZsnpNxcXwZz/+x9Kl/HPIUwpQRCbjISSGE9uIvnauVqFwVwfW6ZrRPv2po0o
         XWGHda58O1gh1arIQH/obADJwL9cjo24ApBDHszjABq7c6YiDfQhRQcVh2gM3ftwdJfh
         eQXdl6EQQzpSsCgs7WNnYpUzZIfIi49zLFRXX+VQg/gXA5GTpYwJp+16yUTxktoJam0Y
         Vvmg==
X-Forwarded-Encrypted: i=1; AJvYcCWUGGuuU/wAjCDMlwsR2JQbcZACZj2RB0dXRwlK2yhGQMksouABNP8t1OdZ6SA2Sw9pr3HA7Uruiag=@vger.kernel.org
X-Gm-Message-State: AOJu0YznTShTx2204fo3+uTuAiUstd/KpDYy/1HvC0R42P+b79j0mHlC
	Vy3vrwYa6vzrOA/Y+E8H/IeIp7lNGQ84L2BmioIot2IebkbcRUUcB4XRsi5+3RSq83CD4wflyQU
	dJDA=
X-Gm-Gg: ASbGncuc3LV0x6C9hBqFXQ62wQ4Dxgy+j2wU0SMSOnjJFL0tLz/KkFw4cOWk7Vcy0cg
	I7FX2CkwOxQLIrYfp17VEME03PP6R5XNZ+59NP+Q0PMICx7xAkjw+gDpmOecFXyU63BYjeneES4
	dsVctIQ5KL3/3YM6R8It5Aq8bI6sTufTTT4niY5+VYJtKuTvr46wbns0DsZkik3vyMYk/IaLw50
	ShJhywWGJdJotpvGusHRa2L0k03IvXg/h+BQHKugYEGq48ImgMHdLkQKNc7UY4gjd1+o6x3gxY2
	/GYtWdihTD4IdvhmlPDZRf4kmREVUv3Zmb0CTIHY6DhHSRb/pTczlRBDKjONuutuEpSiQ9peB+H
	qoArFEVIp5MP02SdTGgE=
X-Google-Smtp-Source: AGHT+IFrI2HtnzMMdn6ZSOxNKhcJlOHJ+0mn6bemjjT+MhX05hysg5H4KYzpXvPtU1WtxjNBKWkFag==
X-Received: by 2002:a05:6402:5cb:b0:5e4:cbed:cb3e with SMTP id 4fb4d7f45d1cf-5edfcec61ecmr2490716a12.12.1743277477557;
        Sat, 29 Mar 2025 12:44:37 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5edc16aae9esm3458574a12.11.2025.03.29.12.44.35
        for <linux-efi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 29 Mar 2025 12:44:36 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-ac29fd22163so548660866b.3
        for <linux-efi@vger.kernel.org>; Sat, 29 Mar 2025 12:44:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV5k8wEEKfK/+3pXY/aBDbpQxok9+qvElNLc3kCm4vyE6CZkZm8JIVUSFRR55+Lev++b3aBaQvqhyM=@vger.kernel.org
X-Received: by 2002:a17:907:6092:b0:ac6:f97f:a010 with SMTP id
 a640c23a62f3a-ac7389e6ba0mr353475966b.12.1743277475406; Sat, 29 Mar 2025
 12:44:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250328070525.2248563-2-ardb+git@google.com> <CAHk-=wjc-EAEtv02iUFGej6RZs9C7ALAMtuh4rFNYs5VUt+4UA@mail.gmail.com>
 <CAMj1kXF61PeyercrHdkevq+UdKvBsfJ4QV2RFJyXMWAYtJ95oQ@mail.gmail.com>
In-Reply-To: <CAMj1kXF61PeyercrHdkevq+UdKvBsfJ4QV2RFJyXMWAYtJ95oQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 29 Mar 2025 12:44:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=whEOe91Wu8AtQSOEAHc1h1e-pheaefH=SnyTp3V2HqeTQ@mail.gmail.com>
X-Gm-Features: AQ5f1Jpi2CdKf2y4ymmQpUeaxcHVUr-Xj5-bYgyhVavzXzl1fbt1fbJhUTj_wwA
Message-ID: <CAHk-=whEOe91Wu8AtQSOEAHc1h1e-pheaefH=SnyTp3V2HqeTQ@mail.gmail.com>
Subject: Re: [GIT PULL] EFI updates for v6.15
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 29 Mar 2025 at 12:08, Ard Biesheuvel <ardb@kernel.org> wrote:
>
> Does arch/x86/lib sound like a reasonable place?

Sounds entirely reasonable to me, with something like "efistub" in the
filename (perhaps even as a subdirectory if there's more than one or
two of these things).

               Linus

