Return-Path: <linux-efi+bounces-1052-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F398C95C8
	for <lists+linux-efi@lfdr.de>; Sun, 19 May 2024 20:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EADD6281970
	for <lists+linux-efi@lfdr.de>; Sun, 19 May 2024 18:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE8E2770C;
	Sun, 19 May 2024 18:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Kvt49UDN"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1F5EADB
	for <linux-efi@vger.kernel.org>; Sun, 19 May 2024 18:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716142517; cv=none; b=FM9pNIZmla09f41OquqjIGgsU3/+432ipYuV3UaAY+dyH+jYIW74d9D/EvUUhbuyQ1Hciz+mSsoTZKSxUw/AOuCx8w2TpF+/ovCIHsueeP8jIVuxt68JQkY87esI/QEdVjB2GrGOb9LmrQkFzqKrGKZX6EaNhfyII3FpLvIwQqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716142517; c=relaxed/simple;
	bh=7aMlUpYXG+D3tRLz8K4ybKHvPVMZ7c7UUXtb/IR5nqo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GSScC9VjqDC0dInFAB4cRQhTvtiDahH+upAbmr3mO3sOY3jQ6rN1ZQHPWvPrBXAkdEk2VvW0UPn9NzVvQqh6T+Ei8NICzmNn67TPoYTw+5HvEcHh82ODiWCR7H7jRq8vBdEJNplmL+mnL/ZXEqmMj7p2nkJ3ahH2MoHNew5EQ2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Kvt49UDN; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1ed835f3c3cso61211135ad.3
        for <linux-efi@vger.kernel.org>; Sun, 19 May 2024 11:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716142514; x=1716747314; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jzOZ7YVghqBo2F/fa+rUY+FNuLS1ZQELoEWyUmcv/zo=;
        b=Kvt49UDN32oVq9iiyjmiXpkIZrp34U5JeMKN4HS3TDga4dOUr6s07QIMzFhbiwOhKr
         hIuCoplTx8fkWq8+Yh80y0NSfUlN0ssvVYs8K0SwdvFS5eYqZsX8avU091QzHVkU/zkZ
         tiggbrDLlXxRotio0tqj/WnpESTqkpA7cvPz0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716142514; x=1716747314;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jzOZ7YVghqBo2F/fa+rUY+FNuLS1ZQELoEWyUmcv/zo=;
        b=HIg7Z3UrYiNk/S3ZDdJbauWsDlGOTAiZlQTxD2+WTiRtxgkUe+0csVJ7FTgjATSfa2
         KGW0SW69DQ4p46WMui3l7GAJYm5b1eRlhssww5X58bICxqXttIFuIux+iGf2yMHKvV49
         aPe2Tjwxm5pP3dL6RU0Z1ZgdJWzrP0Jxah/W3qUX1vs1KLLhtiQdc5WQBjpJvy8y9znK
         QvCwPtfrz6g6yMxOCVxjhz5td7q0HrHz4HV4keljAM0p2trLWAaLmYRn9+xmoMR6Yca4
         w2sTNnRVYcwf+lC5BlbULGdk4nDMscW7L0QojCdErYj3cJk0hs9yS8eGgxdja5HSu0b/
         HaMw==
X-Gm-Message-State: AOJu0YxFtevLw350Ha7E7b1tWLF3fKWEBGPc7nEcP4a9K26j29IUTAm1
	kdEO4I6Z0HDdOEefSWxhVFySB2MHdjzUEc99VJ8TLqmIc4GhtnYG5ojN4P9y3CGiq84pJtQUIjM
	=
X-Google-Smtp-Source: AGHT+IHJG6+ZH93XGOoEQl/FkVnfWHdRCIs6HlPK6t1up+Q5GVekj0cg3DQc5ikbwdVQdEoYm67uUQ==
X-Received: by 2002:a05:6a00:1992:b0:6ea:afcb:1b4a with SMTP id d2e1a72fcca58-6f4e0283938mr35571943b3a.8.1716142514397;
        Sun, 19 May 2024 11:15:14 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4f28bcaaasm14297466b3a.73.2024.05.19.11.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 May 2024 11:15:12 -0700 (PDT)
Date: Sun, 19 May 2024 11:15:11 -0700
From: Kees Cook <keescook@chromium.org>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-efi@vger.kernel.org, linux-hardening@vger.kernel.org,
	tony.luck@intel.com, ardb@kernel.org, kernel@gpiccoli.net,
	kernel-dev@igalia.com
Subject: Re: [PATCH] efi: pstore: Return proper errors on UEFI failures
Message-ID: <202405191114.1DD51BDC1C@keescook>
References: <20240519163428.1148724-1-gpiccoli@igalia.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240519163428.1148724-1-gpiccoli@igalia.com>

On Sun, May 19, 2024 at 01:33:53PM -0300, Guilherme G. Piccoli wrote:
> Right now efi-pstore either returns 0 (success) or -EIO; but we
> do have a function to convert UEFI errors in different standard
> error codes, helping to narrow down potential issues more accurately.
> 
> So, let's use this helper here.
> 
> Signed-off-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

Ah yeah, good idea!

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook

