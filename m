Return-Path: <linux-efi+bounces-4935-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32053B97ED9
	for <lists+linux-efi@lfdr.de>; Wed, 24 Sep 2025 02:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 556C91AE0DF5
	for <lists+linux-efi@lfdr.de>; Wed, 24 Sep 2025 00:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE521C5D4B;
	Wed, 24 Sep 2025 00:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b="Cv6VPlFF"
X-Original-To: linux-efi@vger.kernel.org
Received: from sender4-g3-154.zohomail360.com (sender4-g3-154.zohomail360.com [136.143.188.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4AE1B4138
	for <linux-efi@vger.kernel.org>; Wed, 24 Sep 2025 00:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.154
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758674645; cv=pass; b=Wq2tBf9NZG9G5KHd57MjgvLOe4zSKrG1py9nDtBcVS5F98EQ9NchpVHA/q3nJ/K4G/kbvy8BNryeUjO4y9xUhysuwIbYKJXVxQryj3lAsWP7IyGeHGH4XL64f4mVEChMNHNBskhwWonZzim1jshrr64IgZEffd9oKRZHxv4CqRE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758674645; c=relaxed/simple;
	bh=xAvDYuNgkZ3IFXqLY0nq3vBmAug0xiCRsqqsJWj70XU=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type; b=cjylqs8efN7CyHcnZ0/qkhSmQ/gy2vG92/RgIRuSqPbN/7isZEELskVmdj4jq4h7ktRsHshejf3WddIiK+B3XGJ38GxFZceqsC1+EsFDoZkj8Hy8Ra+vUxSYCCB5b8LvponOtB6duL/eh/cafDdmlPFRjdIm2n53t6ndDziQ7lM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx; dkim=pass (1024-bit key) header.d=maguitec.com.mx header.i=@maguitec.com.mx header.b=Cv6VPlFF; arc=pass smtp.client-ip=136.143.188.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maguitec.com.mx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce-zem.maguitec.com.mx
ARC-Seal: i=1; a=rsa-sha256; t=1758674643; cv=none; 
	d=us.zohomail360.com; s=zohoarc; 
	b=WnFllm/zmPcc//4GUjoX3lHz/euJ4DLw+m/sYJGQLjjTMFZfhU/VoOcflPxeqGX7usCOWUMcE49uUwR/Gz48DFS6OjFD0cR4cldn8ZfZ1jBx+UAKdcugfRagXTLA4WTwdtyFRmrT9qE6GGayOWGJAmEaAPPlrFUBc8mDvXXnQNM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=us.zohomail360.com; s=zohoarc; 
	t=1758674643; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:MIME-Version:Message-ID:Reply-To:Reply-To:Subject:Subject:To:To:Message-Id:Cc; 
	bh=xAvDYuNgkZ3IFXqLY0nq3vBmAug0xiCRsqqsJWj70XU=; 
	b=pZORWjyeXn7J7XLORTtsON6/cQAXZKiGBrDIureRLlpAmGHbFWlvIYqruP6o1AspYTsel7PXHE6bSygZR7g2NXUtZeT1a6hXTkLShS6wd+Obgse8/phd/+nDSj+SVbClpiKg0zmQgVRF2gwDZA7/PQKtefbh8FRLD9ScEEhEYCs=
ARC-Authentication-Results: i=1; mx.us.zohomail360.com;
	dkim=pass  header.i=maguitec.com.mx;
	spf=pass  smtp.mailfrom=investorrelations+9a723820-98d8-11f0-ace3-525400721611_vt1@bounce-zem.maguitec.com.mx;
	dmarc=pass header.from=<investorrelations@maguitec.com.mx>
Received: by mx.zohomail.com with SMTPS id 1758671653442230.22124181274717;
	Tue, 23 Sep 2025 16:54:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha256; b=Cv6VPlFFdjHx8d8YqFSpeMnTYeFXSQEXMhTysl0M6lzRPbusF3fMfSR3ZRSLHtGiOONaZ5Z8YLnEAB1z4rFU+IItTXjI248iYT7GtZgdpZFL3mpHvwMSW+dm3Luz6kXyywgO21KlpiqrV/i/T+DMjyi3ujMAX7pdE4Fl0Xts6J8=; c=relaxed/relaxed; s=15205840; d=maguitec.com.mx; v=1; bh=xAvDYuNgkZ3IFXqLY0nq3vBmAug0xiCRsqqsJWj70XU=; h=date:from:reply-to:to:message-id:subject:mime-version:content-type:content-transfer-encoding:date:from:reply-to:to:message-id:subject;
Date: Tue, 23 Sep 2025 16:54:13 -0700 (PDT)
From: Al Sayyid Sultan <investorrelations@maguitec.com.mx>
Reply-To: investorrelations@alhaitham-investment.ae
To: linux-efi@vger.kernel.org
Message-ID: <2d6f.1aedd99b146bc1ac.m1.9a723820-98d8-11f0-ace3-525400721611.19978ffc4a2@bounce-zem.maguitec.com.mx>
Subject: Thematic Funds Letter Of Intent
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
content-transfer-encoding-Orig: quoted-printable
content-type-Orig: text/plain;\r\n\tcharset="utf-8"
Original-Envelope-Id: 2d6f.1aedd99b146bc1ac.m1.9a723820-98d8-11f0-ace3-525400721611.19978ffc4a2
X-JID: 2d6f.1aedd99b146bc1ac.s1.9a723820-98d8-11f0-ace3-525400721611.19978ffc4a2
TM-MAIL-JID: 2d6f.1aedd99b146bc1ac.m1.9a723820-98d8-11f0-ace3-525400721611.19978ffc4a2
X-App-Message-ID: 2d6f.1aedd99b146bc1ac.m1.9a723820-98d8-11f0-ace3-525400721611.19978ffc4a2
X-Report-Abuse: <abuse+2d6f.1aedd99b146bc1ac.m1.9a723820-98d8-11f0-ace3-525400721611.19978ffc4a2@zeptomail.com>
X-ZohoMailClient: External

To: linux-efi@vger.kernel.org
Date: 24-09-2025
Thematic Funds Letter Of Intent

It's a pleasure to connect with you

Having been referred to your investment by my team, we would be=20
honored to review your available investment projects for onward=20
referral to my principal investors who can allocate capital for=20
the financing of it.

kindly advise at your convenience

Best Regards,

Respectfully,
Al Sayyid Sultan Yarub Al Busaidi
Director

