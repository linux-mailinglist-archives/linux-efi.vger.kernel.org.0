Return-Path: <linux-efi+bounces-2796-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A19CA39E21
	for <lists+linux-efi@lfdr.de>; Tue, 18 Feb 2025 15:01:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F6CF168376
	for <lists+linux-efi@lfdr.de>; Tue, 18 Feb 2025 14:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83037269AEC;
	Tue, 18 Feb 2025 13:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="QUvHzR5o"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5F32417F5
	for <linux-efi@vger.kernel.org>; Tue, 18 Feb 2025 13:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739887195; cv=none; b=JKNW8GWBunbziIq6ZpSUGZzuvnJQqMOWtC3OhaiUOQka0pK04pOXjapaLlkgXwmqmfZd8WliccuRXLP86B/e+QLYtxYRSYa1sZr3l2n4fabp7Tcrsv6lS9M9zwqXuz/7gJ59fziBbR5sGiaVSN3gR9dZIAbgy7o20uyXkrjID7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739887195; c=relaxed/simple;
	bh=oLapzg2kmr8ra4GmoxtioxQBLEe8tuDRu4pDXkNj86s=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=hTti4BUzW1nXmGerty9wQZdwBI4yekB661djxkcSxUy5e/3jRyvXP05jGrKaTcqGRbh2b4iKyCD8VTc1W5Ab3mqmPBnDO1ByKRk6j8k+BODPTuez+yUnstSxh1Jx1dbwHCatWLtN9SIWZdjm1/NkEvJZJNBOSVM6wrELRG8mjoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=QUvHzR5o; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id DF0633FA50
	for <linux-efi@vger.kernel.org>; Tue, 18 Feb 2025 13:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1739887187;
	bh=TFVkVW8mqzZvRa2FQ2uGvuEytv7Dg/puiNRGWYVs8Vg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type;
	b=QUvHzR5oTp70JOo2wgCJP9JMcxSACzzX2Bc70kevRR2UgepF6eD0/jBW5PgTi/Hcq
	 gn8Ae8xSAKx/qRL8AwugpiUcpwMm1k7aFmqu0GtYnTFdCyo85e7dG2xM1v9rxfpB0s
	 fFu72fDOdeTVFXWctYBeltZlhfnG2WldjLf6jOH6F0KwgUQEjmDCxo8WOIBOG9gBuw
	 urAFs06U5V/ND7DuCIspj6m5OhrRhLGdYkgTE+IhLfAnY43yBfENq2rmL0OneRRxCo
	 DIhEgfycs7hFsktlpFEKNZsggwoox0aduoXXi50R9hnsKjGP28X5aUnVdCY2gCJ9L/
	 pGvbM8PokgZXg==
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4393e89e910so29467725e9.0
        for <linux-efi@vger.kernel.org>; Tue, 18 Feb 2025 05:59:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739887187; x=1740491987;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TFVkVW8mqzZvRa2FQ2uGvuEytv7Dg/puiNRGWYVs8Vg=;
        b=SUXW1JsmwECQLuX4IFZ98Wf11IjR0d2xD1dSUbImIR7dTwbhbcgl1YOeAtFgpsWAQu
         y41Fzr6KsUaA5yQNeBjQjPNW9i195okTvv5kveLTQk08jwfR8QaPgJzJMy+dJsDmX3pE
         7Xy0zKaIzotB3BQ8+scd0fOAA6L5bzUMZWiUsd6beYR/2NkQgmqd7GecLi6efgX8iUgZ
         RzfCe8pNeFH40N+YKil3MRXr3RPppvgreLiMoCBT3Hk0J+Ks79+eSLxVV0SdtFFmlvSq
         /qsJUI9c92qI06gVP/Wgu4UKFbrc/63dxTidybw0MXOtudC3+5vtlWrnAQs6LO+cYFyX
         dGRA==
X-Forwarded-Encrypted: i=1; AJvYcCUU8MZHGqXHHJcj+Pga/GHtXAS6E/j4FeZIwidC6bVQWBWiQtkTUb98eMTX7jhIZBHpev3j4L6YEHk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0zXDLr/R3ZfXATHG/idsRolTzxma6pTR1udwwUuS8nRYfAYrd
	gpk2OYEh4rsXrELicbasXW1j86ou8w7j6qDXmBBhVLewQPATSENqIgBh3otXDB6zEywN/xr3J2Z
	iZeSUkJzCf/WIcIau92a94RwDACfponMm//NCVEOg5qdElECAetjIecwIq7B8JA1Nrq04TJTAzA
	==
X-Gm-Gg: ASbGncv6M4E4oUKnmIZonPNUTwNpaAc4cpXAN8Q1dp/DLYGw3fHrg4Y+maQOnrSzXEy
	3Amn2pIMlohnYhVWHnHqFPEqaxmriPZGZ9BIvjEW2FE1SHRZZckkDbRX7oAfVjMdWy2EMbjaPeL
	YNQ434ZGknd6tQ58096vDcHHRX6WX/zdCkGec0EAJdqDReOZtfCwitTNwY+7T3W4J2QSjbuGCtm
	Rm5tXZ09u2GXcuxZrDjwKqebV5D8jH4IPP43bzm5T52LiAHlXrFLcS1MGyqakUArkZ+CpXSVMSG
	raVQk302WjAqjLnrNYmUbkBrUp6H+1GC9S3H0uMzGfOfS7HEW3I=
X-Received: by 2002:a05:600c:1c28:b0:439:42c6:f11f with SMTP id 5b1f17b1804b1-4396e6ab033mr122972775e9.4.1739887187456;
        Tue, 18 Feb 2025 05:59:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkuueM4q9zjyh2zOdRzt+GIWkGfCPkA6ywuytmuiaFKbIi3h6FEUwjrGAeEowaXsN5ZS1O9Q==
X-Received: by 2002:a05:600c:1c28:b0:439:42c6:f11f with SMTP id 5b1f17b1804b1-4396e6ab033mr122972595e9.4.1739887187111;
        Tue, 18 Feb 2025 05:59:47 -0800 (PST)
Received: from [192.168.80.20] (51.169.30.93.rev.sfr.net. [93.30.169.51])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4395a1b8397sm182603185e9.36.2025.02.18.05.59.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Feb 2025 05:59:46 -0800 (PST)
Message-ID: <54095d2f-daea-4e4a-9542-f6a2b7603672@canonical.com>
Date: Tue, 18 Feb 2025 14:59:45 +0100
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Olivier Gayot <olivier.gayot@canonical.com>
Subject: [PATCH v2 0/1 RESEND] block: fix conversion of GPT partition name to
 7-bit
To: Davidlohr Bueso <dave@stgolabs.net>, Jens Axboe <axboe@kernel.dk>,
 Ming Lei <ming.lei@redhat.com>, Pavel Begunkov <asml.silence@gmail.com>,
 linux-efi@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, io-uring@vger.kernel.org
Cc: olivier.gayot@canonical.com, daniel.bungert@canonical.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Dear maintainers,

This is a resend of a patch that I originally sent in May 2023.

Resending with an updated list of recipients since the list has been updated.

Original submission:

https://lore.kernel.org/linux-efi/f19a6d8a-c85a-963e-412e-efaa7f520453@canonical.com/T/#t
http://www.uwsg.indiana.edu/hypermail/linux/kernel/2305.2/08638.html

--

While investigating a userspace issue, we noticed that the PARTNAME udev
property for GPT partitions is not always valid ASCII / UTF-8.

The value of the PARTNAME property for GPT partitions is initially set
by the kernel using the utf16_le_to_7bit function.

This function does a very basic conversion from UTF-16 to 7-bit ASCII by
dropping the first byte of each UTF-16 character and replacing the
remaining byte by "!" if it is not printable.

Essentially, it means that characters outside the ASCII range get
"converted" to other characters which are unrelated. Using this function
for data that is presented in userspace feels questionable and using a
proper conversion to UTF-8 would probably be preferable. However, the
patch attached does not attempt to change this design.

The patch attached actually addresses an implementation issue in the
utf16_le_to_7bit function, which causes the output of the function to
not always be valid 7-bit ASCII.

Olivier Gayot (1):
  block: fix conversion of GPT partition name to 7-bit ASCII

 block/partitions/efi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Thanks,
Olivier

