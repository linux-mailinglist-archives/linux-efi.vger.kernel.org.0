Return-Path: <linux-efi+bounces-4462-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 884E8B0DC11
	for <lists+linux-efi@lfdr.de>; Tue, 22 Jul 2025 15:57:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 344287AFAC0
	for <lists+linux-efi@lfdr.de>; Tue, 22 Jul 2025 13:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62392EA753;
	Tue, 22 Jul 2025 13:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="VywL/X9X"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-il1-f176.google.com (mail-il1-f176.google.com [209.85.166.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217C628BAB0
	for <linux-efi@vger.kernel.org>; Tue, 22 Jul 2025 13:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753192618; cv=none; b=u+iaPTRlwDhuBS6vv+vo93Hz/DFQ22oWzmQQ43mm+2SarAb55O27bs1wE+GjSu0HwPHYyMJH0XfR2PVTJ7Fjdylmt+WJvMzvw+3z8gVkClFY/05fQW9/UvhIsB7Vm75875CzFMOQmkB7mrU4V97hPVgZswfO8hl0HIfK94UPbB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753192618; c=relaxed/simple;
	bh=WD4UPgWwrp87c7JvBmxtXsetEVuHqNKEul4WKe735JY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EE+nc/l6uIsu+guPQMNh8Ql8dUInv/SaQBJuGOtJdTcTMp2RfTQYvQS6BE1BP4pPyv/T06JG3lnrEH2S6FKi8MRESn3qI6BsL/Ab7BPVGvUecMWNk+Rua7k9D/iBy+xqvgCp01s7ojjzewDE1kMM6OWp1wNgt3EqxpNHslMZHgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=VywL/X9X; arc=none smtp.client-ip=209.85.166.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f176.google.com with SMTP id e9e14a558f8ab-3df2f937370so21653445ab.3
        for <linux-efi@vger.kernel.org>; Tue, 22 Jul 2025 06:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1753192616; x=1753797416; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tjmFlUiMS8WhvA/SoS60Dh4RJFEn5lp/yFwJABcPh+o=;
        b=VywL/X9XlLouPHqv4vY9/WsyCGZBjKEdSwRdltghOutRBpeDDfsizJbgrlBN9jDVqu
         H5xgN2/NtYPf0kt7fzAn/NtH3fR3ymSAnoSwFx7p6dd76I5+/kmwEu0xsRtzsxLajfvh
         78HxqmC93Psx0g4wmFsVeC9lw3qWAVOUVPLRsp0HW1Q7e3Ihvr8fh/HhwWqtSBp/Ictp
         kS+wClNzeGGLUYpWcc68wGSRlXjuoalINKMjDy7tocN3aimOVX6NFxxpXJsMNkYh7LJJ
         B6FWCrXWC4Gw1FKszlm1bz9g6OeXMXLwFDzwE4ApB0ttB7KwyLAuJqsbF9TN6ymqEPA5
         bSyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753192616; x=1753797416;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tjmFlUiMS8WhvA/SoS60Dh4RJFEn5lp/yFwJABcPh+o=;
        b=hs3ebrCJMN4iATD3KiDXgBnIbPeuIzLstGLQYEt2hmBlfORc8ixXmNPXmKUPO/H1c0
         ipHhEZDSP2gl+FM0Z+N6TnId4A9cuOrnPoFPwyX69c/d8L3BkDvZi29XQFy9OF4MdCyB
         imuJVyrCa7VxAumj7zgvaiTsz4wIChRXqbEeKobjfGRtQcX4aP4eHDRSwcqcofxRnnJp
         fHAojVZQdgUerwWjDpYqovAx2iAO6nClSzKi2honAayx4sTvV0+LbYOJWFeTEaey4XU+
         EyMs4zEwXccHas7lD+Wi/8PQvwfHbLUZKEFduZs98Xxn1Txfp0I5PFsDfGRTtIVBM9ai
         OR1w==
X-Forwarded-Encrypted: i=1; AJvYcCV3ZmrdEgzc5AtBfTi4M+dfa0T9CGVTCyQU5L/n8lwAZhBpIum/K2WzZS/erFVE97g+nV5X/dQgpF0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiTOgn5rxhdWwtYsv68/2j2ACt3HfocK7Nz56Gh6YkTlqBAVWd
	Fp1VT7o8HWPiKmjC4dLyz8gJYE7inWPp4SXA5AxFy7V3XYFZ83RNHRdk3Uf7uqokpnE=
X-Gm-Gg: ASbGncvIstn56x65j45BZRYx3XkVf6OAJ2AXvzFhJLubWfeBkOR12JSwUCJhogfTTBM
	1T4WgLJ2/5MDQ90pcI+eABtrx2E4xs6SUi061lNWX1VS/g2HxOk2jB9BLuxoFukj233hc3DpBd8
	rahTDmnCA3awktW9HPv5w1VwO/xw14MadNPu62puXtm3CcxTj855X0B5K+FVqi2i7wQBMHtW2BP
	zj2pxvpX5j9Rj/ElYlC3ceVr+5pEuz5iF6zMpJo4BS86DwcM2vmeeB4SQLfcuZVEOx3GDMScSnP
	6P2SgYgrrNSjuhGBIHnbxhHQxQat022V6olSwlUkWkbroaEQ83c5R1CgWFC2UdntWeZtizCY4/i
	Wxtzjdk4Vpdd3h0mv6j9gWJSaVrGO5g==
X-Google-Smtp-Source: AGHT+IFDr+fErNv5tH7IdOj2j7uUgenlIGzMOgYCLt1qeLE9jnEGv4AQM7YVl9je3Z12CEdDAW/qHw==
X-Received: by 2002:a05:6e02:1fe4:b0:3dd:cc4f:d85a with SMTP id e9e14a558f8ab-3e28d3b88bamr240624905ab.6.1753192615551;
        Tue, 22 Jul 2025 06:56:55 -0700 (PDT)
Received: from [192.168.1.150] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5084ca5f843sm2502681173.129.2025.07.22.06.56.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jul 2025 06:56:55 -0700 (PDT)
Message-ID: <62b5f680-5d54-48e3-979b-8d09a876130f@kernel.dk>
Date: Tue, 22 Jul 2025 07:56:54 -0600
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fixed several coding style issues in the efi driver as
 reported by checkpatch.pl:
To: Dishank Jogi <dishank.jogi@siqol.com>, Davidlohr Bueso
 <dave@stgolabs.net>, linux-efi@vger.kernel.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Manish Narani <manish.narani@siqol.com>
References: <20250722121927.780623-1-dishank.jogi@siqol.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20250722121927.780623-1-dishank.jogi@siqol.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/22/25 6:19 AM, Dishank Jogi wrote:
> - Moved assignments out of 'if' conditions.
> - Removed trailing whitespaces.
> - Fixed indentation and spacing inconsistencies.
> - Replaced 'unsigned' with 'unsigned int'.
> 
> These changes improve readability and follow kernel coding style guidelines.

Will only cause backport/stable issues. Please don't send checkpatch
fixes for existing code, it's for new patches only.

-- 
Jens Axboe


