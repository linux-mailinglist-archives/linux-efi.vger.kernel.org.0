Return-Path: <linux-efi+bounces-5827-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 32610CAEC07
	for <lists+linux-efi@lfdr.de>; Tue, 09 Dec 2025 03:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E1C4301B4A0
	for <lists+linux-efi@lfdr.de>; Tue,  9 Dec 2025 02:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B04A2ED15F;
	Tue,  9 Dec 2025 02:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IL6S2tLA"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7033121C163
	for <linux-efi@vger.kernel.org>; Tue,  9 Dec 2025 02:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765248321; cv=none; b=aG425xewclBesh8hBv2YnMywJpafiSluxTFVnI9xPLv+STMLHUXCv/gCZrfmQZvQSkRI+G/VC/5pvzrJZnGOBqBrqiPtQXv060e/+BCgbw2iWOkD2D6fNhx5zQWEAUP6PotYyhmkCpVCUzdQGvxKjqomkaNAaEwjxvTGQ5CuVBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765248321; c=relaxed/simple;
	bh=FyJkIggRHO8k4F9Tvk0TheBChDEYPt1mFUPjqtLH6+s=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=WEwSONn1CgrFkNKV5Yoqy7ey5BfAaKuXmTCW2Pp2eU5/fJhxABzA2RNGozOYOSzO3kjCa16f+bE4f6YwZfe/bo9R9X9oo/nhscvP7MIdRra73rWACASJ+zRAy8jNGRkfN2glF/htqHSk2cgQYvMlDl4G6zbs/cnVI+cfG+UtEn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IL6S2tLA; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477bf34f5f5so39996455e9.0
        for <linux-efi@vger.kernel.org>; Mon, 08 Dec 2025 18:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765248316; x=1765853116; darn=vger.kernel.org;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FyJkIggRHO8k4F9Tvk0TheBChDEYPt1mFUPjqtLH6+s=;
        b=IL6S2tLAlVUfo13gqueYPheYlJnmRkb79/zriS6LbhHfd+ZjWFH3EJOc/SPuHjVazf
         9iua8o+cgLMIDdgbU6CY89bYoK8aovulKO1W7Mj+1UM+IsGwA+ihgizSEOwegsJgXhPr
         jWYsXIhgqcswd+KtosCYghaXwgaKTHS5RTpX/B9HAFhQPiXUokZ0d+FZc8fLqnUaJxln
         ESlWq3T0PP/EgQWtOzkOkmfgD59PvC7fbUURahXEL/CvSxGZkH95bfPKiNMRJmA7Ehax
         470+K2LONzSWj96FgrJ5on0wFja39qCV/BuXsE9a6T5BTY5RoliW3Z+piRwaOUq5TVfS
         1lMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765248316; x=1765853116;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FyJkIggRHO8k4F9Tvk0TheBChDEYPt1mFUPjqtLH6+s=;
        b=tulAQGnlPJPU/yWhrIhEUyaZ5mJd8vH7qgn3p20v/7arMA7iRHP8yVitr+1+YrbvA2
         9pDdV37ODpMW/M0Q9w2V2mAXcrjw4hk3sZC5pwEjl/CzIFICb7q6ihUNCKs5KjbOO1hg
         A4B8xAS8QKXcu/9cHniK/z6tFFxj6bvrS6kcGROE8Gdyd6R5fWBskzE51E0jdchfzo+q
         50T8wQ0UBtJVQkDeZ7THX+IbhgcdfqbLcPzg5scnO7XKnMQLYpoWZ0zt/V11HgHjC5n2
         3wz8Y2AWwOJ1lgbd8ARXsd1BtbdZA6Z19Wm4yGaKL+31h9Kd0jpz9DL+gpu4rQUzuRa2
         cOxg==
X-Gm-Message-State: AOJu0Ywac2tYTYRUTvuLdNCY4l1vAGqYZkOumm+F8/FaXnC4w00oEXli
	ilDjqiDluQtiOGBC2L8NLiX5qx/uewsIx/AUmuUisu3t+tvkbcxuWmouORqpFxWbNlxSxiqjkTD
	/6mA0my0=
X-Gm-Gg: ASbGncuTaOYARQrlcDAUC+bGCv7doVcTYVA19l4ILHC5y25u9sHiUwTH5sZ9PjXtZcO
	JRDl1lXnqDiR8TihopddHDIph5c89RE8MfZ4TXspNaE1mVe4YN+x4h0ialNsJ0toeD1BnLHal9q
	J8PbamQOEhuUnSgEAUL7fD2ZkX5+l4wiTZrWojH9xcvg4JhSEeIMzWoCs1cBIdV5nd4uCMmaME/
	Cqlkt5AlWr7CKxCe5XcG5/QUfpyIGc0TPNPG6oUQHDCyW33P7DEcF3o7kJp9Xb3dHjQxsdPFcKX
	fvCRWvUxMIDrvAnEXC1YvZzog+Cjp8zyxN06IvagaHatJ9cTVsdXiKSVQLCyn7e+yls7J8OqcA1
	HVgljidvZEupIXXSv0sJwweh2HPQbPzJuUfLryfYMWGUGN9igzOPg9iwOf2IOr6UJGTxE2nv6JQ
	O3E2CQ8ohpiCbIKjn/kV2HdcTXSbDRB3NhuyZy
X-Google-Smtp-Source: AGHT+IHA2tNzr0hrI3Z29HOwDVkYHI9K+/tsw2cyKAuGVkhtfihzDsbadS1bKj+RNxjSJFFbjjjhJA==
X-Received: by 2002:a05:6000:2409:b0:429:8daa:c6b4 with SMTP id ffacd0b85a97d-42f89f0be15mr9000225f8f.21.1765248316505;
        Mon, 08 Dec 2025 18:45:16 -0800 (PST)
Received: from r1chard (36-228-74-249.dynamic-ip.hinet.net. [36.228.74.249])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42f7d222478sm28299872f8f.20.2025.12.08.18.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 18:45:16 -0800 (PST)
From: Richard Lyu <richard.lyu@suse.com>
X-Google-Original-From: Richard Lyu <r1chard@r1chard>
Date: Tue, 9 Dec 2025 10:45:06 +0800
To: linux-efi@vger.kernel.org, ardb@kernel.org
Cc: jarkko@kernel.org, James.Bottomley@hansenpartnership.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	ilias.apalodimas@linaro.org, jgg@ziepe.ca,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	liuzixing@hygon.cn, Ge Yang <yangge1116@126.com>
Subject: Re: [PATCH V6] efi/tpm: Fix the issue where the CC platforms event
 log header can't be correctly identified
Message-ID: <aTeNIqZnpYWhjJ1Q@r1chard>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.2.13 (2024-03-09)

What is the current status of this patch?
Link: https://lore.kernel.org/lkml/1752290685-22164-1-git-send-email-yangge1116@126.com/

Best Regards,
Richard Lyu

