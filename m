Return-Path: <linux-efi+bounces-2771-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B18C1A2D43B
	for <lists+linux-efi@lfdr.de>; Sat,  8 Feb 2025 07:21:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A5CE16BDC9
	for <lists+linux-efi@lfdr.de>; Sat,  8 Feb 2025 06:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5ED9194096;
	Sat,  8 Feb 2025 06:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=truemaisha.co.tz header.i=@truemaisha.co.tz header.b="DlCsYoor"
X-Original-To: linux-efi@vger.kernel.org
Received: from server-598995.kolorio.com (server-598995.kolorio.com [162.241.152.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53BA015098A
	for <linux-efi@vger.kernel.org>; Sat,  8 Feb 2025 06:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.241.152.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738995658; cv=none; b=k1GEHmf9MStV7SoxVt88/jgowl5FOXkcqXKPr1tpBnVfug5yUMLCR2mFxZ/hIrWOBsgnn9GgEbK2svpkqpWDEveBTwqNeuE3VZ+WZ9VxLpdFA9vP6eEBpj3CE9FiypPwF1qoHZMp6rRqqbK/WE7UfMssVF2x+fd4xZjOY7esOJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738995658; c=relaxed/simple;
	bh=gl4+7vNxgV9+JzZtw7EthQ6aGDgi0WVn3wQV/lnKiyo=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EO1tHdqtVnlcHVCZBmKJMWrx94nYOwfphYuoan73G9tHllCiwuTGCKSh3ipVPNncvmWp8cup5seVKmVmhCfdhxUAsGmkVkevmR2mRxFQVFAn9IgNupRzCQ9fm0WzAPT4DnaUY44xi1uvTEpRoWUsdMuhG9uUO6sEVULaVcNw3Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=truemaisha.co.tz; spf=pass smtp.mailfrom=truemaisha.co.tz; dkim=pass (2048-bit key) header.d=truemaisha.co.tz header.i=@truemaisha.co.tz header.b=DlCsYoor; arc=none smtp.client-ip=162.241.152.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=truemaisha.co.tz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=truemaisha.co.tz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=truemaisha.co.tz; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:To:From:Reply-To:Sender:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gl4+7vNxgV9+JzZtw7EthQ6aGDgi0WVn3wQV/lnKiyo=; b=DlCsYoorzRI/pOIfKxgT2qwcPs
	MiXwrHg3Hnu6mjP122uYkTh8E3RRCZo/lt8//uEOBLHp0C5RL46Mg5V2U3ztSbMJ1TfXU/BBbF57/
	uqNIA0kdg9pT2wJi7v8f4ryx30Hsn1v8jkC/lj1snLrbsQzXxuFfXLHgRST7lOAAeVMCgZMdcfry3
	yQpGsimfACI5TgSCdJp3HDHfOgQxBMuW36ndzor8LFRF/fMQKfHIuu+S4BdfBEOFvsldHNFoOotl3
	wTN13eFS8YLMGcDDLHFn4c5G1N0lggSsdM7WRp7jCtVeSUsStW+4KjooaFHhnlDvB4c1KN9YHuE8K
	XG42j9Vg==;
Received: from [74.208.124.33] (port=54039 helo=truemaisha.co.tz)
	by server-598995.kolorio.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <chrispinerick@truemaisha.co.tz>)
	id 1tgeCz-0003OZ-0Y
	for linux-efi@vger.kernel.org;
	Sat, 08 Feb 2025 00:20:54 -0600
Reply-To: dsong@aa4financialservice.com
From: David Song <chrispinerick@truemaisha.co.tz>
To: linux-efi@vger.kernel.org
Subject: Re: The business loan- 
Date: 08 Feb 2025 06:20:55 +0000
Message-ID: <20250208015436.552D9D97B3ED6299@truemaisha.co.tz>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server-598995.kolorio.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - truemaisha.co.tz
X-Get-Message-Sender-Via: server-598995.kolorio.com: authenticated_id: chrispinerick@truemaisha.co.tz
X-Authenticated-Sender: server-598995.kolorio.com: chrispinerick@truemaisha.co.tz
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Hello,

My name is David Song, at AA4 FS, we are a consultancy and
brokerage Firm specializing in Growth Financial Loan and joint
partnership venture. We specialize in investments in all Private
and public sectors in a broad range of areas within our Financial
Investment Services.

 We are experts in financial and operational management, due
diligence and capital planning in all markets and industries. Our
Investors wish to invest in any viable Project presented by your
Management after reviews on your Business Project Presentation
Plan.

 We look forward to your Swift response. We also offer commission
to consultants and brokers for any partnership referrals.

 Regards,
David Song
Senior Broker

AA4 Financial Services
13 Wonersh Way, Cheam,
Sutton, Surrey, SM2 7LX
Email: dsong@aa4financialservice.com


