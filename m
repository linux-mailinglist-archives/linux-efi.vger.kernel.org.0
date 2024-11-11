Return-Path: <linux-efi+bounces-2133-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A669C49AA
	for <lists+linux-efi@lfdr.de>; Tue, 12 Nov 2024 00:23:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69936B26309
	for <lists+linux-efi@lfdr.de>; Mon, 11 Nov 2024 23:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60CDB15C15B;
	Mon, 11 Nov 2024 23:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YEltwjjU"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C574215B122
	for <linux-efi@vger.kernel.org>; Mon, 11 Nov 2024 23:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731367382; cv=none; b=qk56LW9jOnou/zUBR4M+VWocwCvhjHKPWlA7X064jPjm1TiLdDXg7OBr89bEtdnEQSVcgTVYSk09WJF2UfrGQlRD+wr4AGIz2n/8CE9xT0npzP7gD8TAq5hEtIbpy2u8dCDc6+TVe9psu9hcqnQ0FsHvmFRGEgDSvak1yYE5atw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731367382; c=relaxed/simple;
	bh=mqk98GP19dZ+Ay7HEP68kLZER2bT/NkIqYTu8jMJ4BE=;
	h=From:Message-ID:To:Subject:Date:MIME-Version:Content-Type; b=h8LIHH45uC/WXn9qUtvKD7XhCZgwzWe/UXil5zuQpHpUaJ0p5agyBMWRvIhYV8BStb6uNkjyYJx1nNlXbRs4ndBMvW2T51ZeST/o6a4NXgDhfZejh2jq5FiAnw7SUBaPpDwu3LbTmqwDOxDp2CbWw0XYhwDFRNJHuefGXT27tMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YEltwjjU; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43193678216so48131085e9.0
        for <linux-efi@vger.kernel.org>; Mon, 11 Nov 2024 15:23:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731367378; x=1731972178; darn=vger.kernel.org;
        h=mime-version:date:subject:to:reply-to:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mqk98GP19dZ+Ay7HEP68kLZER2bT/NkIqYTu8jMJ4BE=;
        b=YEltwjjUBzUuS/iUO4PVA+9gqjaJmlI0l6jPY3ks+1aWvrqZUxIQeFR4jpFkyH5FIi
         8JKpGPx4uIN/1ugL3BUL7trlpRbgVjhcoDFIpUjopf5SJl7q6/aMdEbNp5J8SbYI+vZP
         B8KEHwsKHFppkwwUirW//1UERbG9zJRftgyTZqcqxA0wwoYkTABBySplWxgVMxNKAzO0
         T7yJ69viBNxb9Rr3KJQQTINZre03dqFYGupC3DewPxZiOuY7TTncoXCfm77fAC6jbNrU
         L1Xs8YGXVtmGcOFI44Sj6+i6wg4rj/lKzFi98EuuhhR9ra/V9EuRbwJMy4jK89IIeHHL
         KvAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731367378; x=1731972178;
        h=mime-version:date:subject:to:reply-to:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mqk98GP19dZ+Ay7HEP68kLZER2bT/NkIqYTu8jMJ4BE=;
        b=fVbYuNIGsh6udMzpyA2rQku29YTdFNQXLnmmDpexsG6e+jQ/Z0sW84PfhVobaPdVwT
         o9dKrwtye2Yht2/CmbzwYZjmFIOo3hlikCWl6d4WWfkJ+jJRBUQaLRLB3muoPxiIQhUA
         E9Vk9Dm84ZH2+ndeaOL9puhjAAyfN/TJxHEA/ctgQEQ9EbBRo3JkRdpjMDxdcABZWc0Y
         FKvaswkesFdE+8wQjXVh/kDCT/T+wPwzeqkeRXjljA9PEEBvspuGX/F5QZjgJhDBnTfw
         z28JkCiG8DrxE1FQWDh1ESPNOKvUtzswXjmkkIMlN2DUFK29X47KPsKXii+x9Vb4OHpJ
         5t8w==
X-Gm-Message-State: AOJu0YzEcR34I9UJP/rEkOHxgIHFehDPKpLBDAS8UH14BRtSUyuc5T2W
	a2Yl0Stg7xq8St5x7EK/1zEdZj4st9QiC2au7bb73RTGE1EW3kebhLVAvg==
X-Google-Smtp-Source: AGHT+IFIcATg3GPI2Jz7fJicbu0TAM42lX2jsMBmrmpcOM4RCoC1JVBiMTZDM1luB1Iwj+Y9Ram7/A==
X-Received: by 2002:a05:600c:1d85:b0:431:5187:28ef with SMTP id 5b1f17b1804b1-432b751c657mr124226175e9.33.1731367378314;
        Mon, 11 Nov 2024 15:22:58 -0800 (PST)
Received: from [87.120.84.56] ([87.120.84.56])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432aa70a1d8sm232523925e9.27.2024.11.11.15.22.57
        for <linux-efi@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2024 15:22:57 -0800 (PST)
From: William Cheung <royfootef@gmail.com>
X-Google-Original-From: William Cheung <info@gmail.com>
Message-ID: <cd8baebad9cf859f5ad75c395dec508f8e8f951bd2f11ac2a349c9576a00efbd@mx.google.com>
Reply-To: willchg@hotmail.com
To: linux-efi@vger.kernel.org
Subject: Lucrative Proposal
Date: Mon, 11 Nov 2024 15:22:30 -0800
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

I have a lucratuve proposal for you, reply for more info.

