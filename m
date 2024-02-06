Return-Path: <linux-efi+bounces-486-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4BD884B52E
	for <lists+linux-efi@lfdr.de>; Tue,  6 Feb 2024 13:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77DDE288DA9
	for <lists+linux-efi@lfdr.de>; Tue,  6 Feb 2024 12:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52297131756;
	Tue,  6 Feb 2024 12:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TouJM67F"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A2F131755
	for <linux-efi@vger.kernel.org>; Tue,  6 Feb 2024 12:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707221762; cv=none; b=WoQ4RA6Uvq3SZmS+5cOr0CPZ5H5AYzNw0I5t1hlUvBdg+wtfJO3ejELkaEbjxeQw7orsW52ei+cA0h0jQrQ6fIVgc3szBhOuGv+g6Id5+VvRru9+SQfJHlrcFkQyCxoC1DgxteW95pqw4XyOdWOCw62KUw0H9m+Hnv5+joDUAUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707221762; c=relaxed/simple;
	bh=HJfXMU9hPHA15MExsi/vE6dZupPM9XjEQmJsMztkuas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=POdfuixpZCxiC4LNReR5plsZMSqAv5f4R+k78ixUk/Sx9kf5AJAlra7fBYkJ1q8LUVGA/NFnDjhS5eAJvT0JXoWFiTdsbWXggubebO0q2WtWOte12bCGLaKyjFdF8kB1k8cl1mZ1xK9Z6hbG0SeWNQ7K/qJ5cyFmzWZHfXX5WvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TouJM67F; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33b45befbbbso514185f8f.2
        for <linux-efi@vger.kernel.org>; Tue, 06 Feb 2024 04:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707221759; x=1707826559; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HJfXMU9hPHA15MExsi/vE6dZupPM9XjEQmJsMztkuas=;
        b=TouJM67FB/U6Vow4DWL9LDqIK2EGqnf6UM4havCQ8PWC/RxipvQ2Kf9CZvJDE37Zp8
         Ak9w2b/HrI0VjFhERM9njMN7vJ9Gnzz8tEB8WjOqsTx0t1kEIqGmzBHkhtM6/5v1kDHh
         vubhBWpXl0E6dLZuUVyFxmnEeqEcEp1s+/VUI4WLY+1ZOeRRkTlV3afVVImiYIsoYoKr
         puJWWm+3ftKfGlAKwK3HyBA1Cl2B4wDeGw1S5cup5OriVESDmSR5aDylgxIZZ3MgY45R
         DHDwdAGa6I83/j0H6sphookON4QvtvFnE0clmNgsOMu+ewr/I+cOzHL8OXInG1faW2tX
         Eznw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707221759; x=1707826559;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HJfXMU9hPHA15MExsi/vE6dZupPM9XjEQmJsMztkuas=;
        b=bxN5+lHFedMfiUcNHH3aGikGT7yk+vDstycW9/9IO3xGR6KvxTqHS2YD6bbqxPtMke
         hAiSu+rzrvPIufadCnQ27npCeJv1amMPIefDT6iTMc1xVQQV4CBffxxsTZB2heyypFAY
         fvGDb2/9WaCM0VOsw9wKV2JQ/8HOzX77n7i0Hd5e+ToDp0zsLB/glKg+Xf4Ky3lU6zmU
         ewFvdemsuSNEMynk0QBtdL1E+NNJ4KfiTO/Fbe8VtpgKUJ70xVjCvrc7jdrQElm54J3q
         PyJQowqzkAKM3wEkn+BebWSguVFTrrmdSBy8vb65mUar21OyzcC91325PiX1lnxLblXS
         FPBw==
X-Gm-Message-State: AOJu0YzGvidx1lBxddiVrgeTL/xOVkiZ0I0kn3aYdYH18Fij8BMGS+Jx
	vxhKRYP014pD52SDkwqflrgAVUPv4ApBb73W0V3FjbSqRPTKv6oroOzhV4TjWwireUbp/i+urGD
	TrBcgCc0YhO83Cb4Y5HkYOLrITB0=
X-Google-Smtp-Source: AGHT+IGdCZ1Q45ex79FTxLxNHOXSTxMX2HwDOEEP4Ngk6m5XuJoyhIC6wPz9zsOCCD20FmgQVPy1qrgqd/0PFn/6KmA=
X-Received: by 2002:a5d:5f44:0:b0:33b:3d35:1ee9 with SMTP id
 cm4-20020a5d5f44000000b0033b3d351ee9mr1169243wrb.37.1707221758537; Tue, 06
 Feb 2024 04:15:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1707141974.git.baskov@ispras.ru> <82e66a8c9ae70e416eb8ae5229cf5a93f17921b9.1707141974.git.baskov@ispras.ru>
 <CAMj1kXHTyq6=hVOYa3u2y0GRcrG6wCFA8OqrELZXQD+EGwdMuA@mail.gmail.com>
 <62e0169a301b68f2b985d1a8659f1363@ispras.ru> <CAMj1kXGg4c=4Tk4PCSJRCpMTRQ-M2c54QqrfRuOzZoWBYab3oQ@mail.gmail.com>
In-Reply-To: <CAMj1kXGg4c=4Tk4PCSJRCpMTRQ-M2c54QqrfRuOzZoWBYab3oQ@mail.gmail.com>
From: Mike Beaton <mjsbeaton@gmail.com>
Date: Tue, 6 Feb 2024 12:15:47 +0000
Message-ID: <CAHzAAWQJ-vCtCXBA0QL7asRwejE7NfEuaT2zhCBa+2Ek5gHqaw@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86/boot: Order sections by their RVAs
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Evgeniy Baskov <baskov@ispras.ru>, Alexey Khoroshilov <khoroshilov@ispras.ru>, linux-efi@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 5 Feb 2024 at 15:23, Ard Biesheuvel <ardb@kernel.org> wrote:
> Thanks for confirming!
>
> I tried your patch too, and it makes the signing tools unhappy (see
> below), so I am going to stick with my version. But thanks for sending
> a fix in any case.

Tyvm Ard and Evginy!

@Ard, Could I ask whether this fix is definitely/likely/probable to go
into Linux kernel 6.8 final version? (I don't know as much as I
probably should about release cadences, and relation between release
cadences, for kernel efi vs. kernel other bits!)

