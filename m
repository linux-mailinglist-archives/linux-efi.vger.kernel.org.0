Return-Path: <linux-efi+bounces-3537-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D4BAAA7563
	for <lists+linux-efi@lfdr.de>; Fri,  2 May 2025 16:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70AE39A0615
	for <lists+linux-efi@lfdr.de>; Fri,  2 May 2025 14:54:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1039256C61;
	Fri,  2 May 2025 14:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+guZOhg"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700D62561C7
	for <linux-efi@vger.kernel.org>; Fri,  2 May 2025 14:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746197669; cv=none; b=WKtXMDLuk2uWT6xUvwOPWPuvkIj/TmsVxpJhGs88VOdlwnrvUhJwIaQIijt6sJVO9Q0gQHUbDfMdTVicFl5DFyzeKmlV9lsZigjv5fo7DfszS2vvh6Nd0aaIgZbyOa3RL54OInjzx5ZNIVxs4JT5K75xIr+26xVIRVL8ZTB9hFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746197669; c=relaxed/simple;
	bh=RpJVwCDKSnByw8jtUR+cMwoe+OU/wu1hEclu+sJDocE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=B/WAZ/Yq9cL/o/e3mgkuPZFT+1IeVxglapSOX1QPx7PW0HDO5839BVzRZzEmT4NEnlsJyju4czWaRxKJHQswwW4gmo7eI/aN7fnlp2a4Jyw4erTZartb0L7C1WJ7HtbWRRsz9eZ7hXpj6Y0U+190khkJx73zVrdDaFUn43YsL8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f+guZOhg; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-30820167b47so2169248a91.0
        for <linux-efi@vger.kernel.org>; Fri, 02 May 2025 07:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746197667; x=1746802467; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :reply-to:date:from:to:cc:subject:date:message-id:reply-to;
        bh=APu7gvDG+GWIH3CqaZfGtDjeCKACn6athf5zXmMCeek=;
        b=f+guZOhgiDKmsrsS466bXeNWxGqDcW9CwCq1+sSGvacCAGOHceQLq7zFeQR9Tfv4sp
         U8XuN/9kbTom2aSGHhO+tLReijC38flygKfUKvNEmb6IQO4Fju0FkkgcV6vIx50yKLWW
         fMx12ncYCi1mdhFxJ+qjnFWOaTFsLaiQO6uL6bvQX0DzvCR/+wwPO6r8+R9N5QEYo5vb
         Rj9nmalAZfpkQDpBg4BH3LiTv/ZChYVH2EdrH/8ts/ifc3tF6r2ig9jJmHrv/3f8PEQE
         ixXGFykhGuz4vLG8Bgnl+jYkU8xKfWytq/kcZwHLoZHK/dJ229eDSQLLNGZq4sp+MJYm
         8pog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746197667; x=1746802467;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :reply-to:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=APu7gvDG+GWIH3CqaZfGtDjeCKACn6athf5zXmMCeek=;
        b=TqmFUyay2Fq4neqHyodtaPS9f8WsAOAXwC4Ez1ah9B5tgl+rhZJo/cN+M1DRVg2dNo
         UC8eFDmeXB2THzCnz6k2FamRBNrOHERoz2++JKpUGz/rseH0r6ZcdkDOP/6qXkEcKHyq
         OEQYO6E/VjWGsF+VFizh+gl75x8m8tMKLEiU7ZSCw32l4FeIyXbc8VSJDW0vDptTU0xB
         2218AKYDS/BO9psA44GaHF6TxyOOu9ruxJlisQEMTedF9zw2dvyGJH0dxifzS3ab2UTh
         YNPi1Qzb+P2Mck0wu9Q2cgUckfXnw+1Bwk3tT7wlUvpBGzYcpNQ4yJb2HL9h9IsiFPvf
         GHTw==
X-Gm-Message-State: AOJu0YyktKyrCFtV7uZ2Fa3Pl64Kw3GMbRp0pSfk0mKwFCKynduIfSV/
	+VOBJ9DL1Mg4Q92/AaqmTI3BYnG38RHiXtCi1zzWzC2XU2HUtXhu1zVuhR2hq/8=
X-Gm-Gg: ASbGncvfsD3Nf1yh/5l1W5uwtLuwowrp8AYNF/cRRuhVXpjQ9Y3LEm+1bmgUgr96Y81
	3fZWF1weaiaDc5T/6EhZlc3rNIGIEzULX2ZV87Inrs/OAER53ZdsIZ54C5L++4ytSuNmmVvyiSK
	HYNHVbVh8ySNcykyR6feP26gkgh/TrxrmoR9QJAXTdVE6SQ7HLDHTv0aitMHjNOBGSdnyqJ1YAN
	NKKheSmaOc47dd2ERoygR4o1uf1YHR3feytVTcOqvT6j/IihuN4nlPjC8GbP6vsVriR+fXzqaKl
	Hv53LMtTPqEK1bFtcXb+bpzc1l8g6CpyOWDMkcRwwKf1Hq1eZPYY5hGy4iHpQj4C0cBpjGGkVcq
	kmy5BTj1YRAEFK3AS
X-Google-Smtp-Source: AGHT+IHooB7gkLuxsDM3ORWo56myH54An11lZOv2svkEY+b1T5yCT93zgTTM133FcWtFmSbxQEZTXw==
X-Received: by 2002:a17:90b:55d0:b0:2ff:71d2:ee8f with SMTP id 98e67ed59e1d1-30a4e228565mr5319024a91.13.1746197666446;
        Fri, 02 May 2025 07:54:26 -0700 (PDT)
Received: from 179-190-173-23.cable.cabotelecom.com.br ([179.190.173.23])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30a3480f0aasm6423373a91.35.2025.05.02.07.54.24
        for <linux-efi@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 07:54:25 -0700 (PDT)
Date: Fri, 02 May 2025 07:54:25 -0700 (PDT)
X-Google-Original-Date: 2 May 2025 09:54:23 -0500
Reply-To: sales1@theleadingone.net
From: Winston Taylor <sglvlinks@gmail.com>
To: linux-efi@vger.kernel.org
Subject: wts
Message-ID: <20250502095422.6B2C34221557A130@gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello ,

 These are available for sale. If you=E2=80=99re interested in purchasing=
=20
these, please email me

 960GB SSD SATA 600 pcs/18 USD

S/N MTFDDAK960TDS-1AW1ZABDB

Brand New C9200L-48T-4X-E  $1,200 EAC
Brand New ST8000NM017B  $70 EA

Brand New ST20000NM007D
QTY 86  $100 EACH
Brand New ST4000NM000A   $30 EA
Brand New WD80EFPX   $60 EA
 Brand New WD101PURZ    $70 EA

Intel Xeon Gold 5418Y Processors

QTY $70 each



CPU  4416+   200pcs/$500

CPU  5418Y    222pcs/$700

 

8TB 7.2K RPM SATA
6Gbps 512   2500pcs/$70


960GB SSD SATA   600pcs/$30
serial number MTFDDAK960TDS-1AW1ZABDB


SK Hynix 48GB 2RX8 PC5 56008 REO_1010-XT
PH HMCGY8MG8RB227N AA
QTY 239 $50 EACH


SAMSUNG 64GB 4DRX4 PC4-2666V-LD2-12-MAO
M386A8K40BM2-CTD60 S
QTY 320 $42 each


Ipad pro 129 2021 MI 5th Gen 256 WiFi + Cellular
quantity 24 $200 EACH

=20
Ipad pro 12.9 2022 m2 6th Gen 128 WiFi + Cellular
quantity - 44 $250 EAC

Brand New NVIDIA GeForce RTX 4090 Founders
Edition 24GB - QTY: 56 - $700 each

 Brand New ASUS TUF Gaming GeForce RTX 4090 OC
 24GB GDDR6X Graphics Card
 QTY87 $1000 each
=20
Refurbished MacBook Pro with Touch Bar 13 inches
MacBook Pro 2018 i5 8GB 256gb quantity $ 200 EACH
MacBook Pro 2019 i5 8GB 256gb Quantity $ 200
MacBook Pro 2020 i5 8gb 256gb Quantity $200
MacBook Pro 2022 i5 m2 8gb 256gb quantity $250 EACH

 

Refurbished Apple iPhone 14 Pro Max - 256 GB
quantity-10 $35O EACH

Refurbished Apple iPhone 13 Pro Max has
quantity-22 $300 EACH


Apple MacBook Pro 14-inch with M3 Pro chip, 512GB SSD (Space=20
Black)[2023
QTY50
USD 280


Apple MacBook Air 15" (2023) MQKR3LL/A M2 8GB 256GB
QTY25
USD 300 EACH


HP EliteBook 840 G7 i7-10610U 16GB RAM 512GB
SSD Windows 11 Pro TOUCH Screen
QTY 237 USD 100 each


 Best Regards,

300 Laird St, Wilkes-Barre, PA 18702, USA
Mobile: +1 570-890-5512
Email: sales1@theleadingone.net
www.theleadingone.net


