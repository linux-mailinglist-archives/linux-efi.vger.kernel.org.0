Return-Path: <linux-efi+bounces-2688-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A074FA16876
	for <lists+linux-efi@lfdr.de>; Mon, 20 Jan 2025 09:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57A9A1889405
	for <lists+linux-efi@lfdr.de>; Mon, 20 Jan 2025 08:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCC0A1974FE;
	Mon, 20 Jan 2025 08:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t4c.dev header.i=@t4c.dev header.b="bSOPBCtt"
X-Original-To: linux-efi@vger.kernel.org
Received: from qs51p00im-qukt01072702.me.com (qs51p00im-qukt01072702.me.com [17.57.155.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED3D8194C92
	for <linux-efi@vger.kernel.org>; Mon, 20 Jan 2025 08:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737363194; cv=none; b=VPBkGTMIvNLtVuJZvtRJWFV5wxY3ZzZkSc+Vdg+Tbh9F8I0pjR9vx5OG0wainRiPByBJRY0pXMem/LSyx9+R1faeyqzuBTvWoIyrU/HdR5EgbckF/iqdkrrMYCxE6f5Jal2cuFKl7e0Gx/jlQPy8fGgbRhP6wKR4yiulzVTmKyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737363194; c=relaxed/simple;
	bh=852lip/wfJFnxoF9XrRiP8ZoG657RE218TpXlGdjgsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i9EjPtt2KqV4wcLlh0ekdZjIdMYZuYG5jtkd7ncurB4N6TMVj8tWZ7heU7h3u0u6uGTMXBUiG9he5o6DVQ4zNF4vNaVi8HNl7nd8CepzCaWFfWEiEGJeyjj5p64te2YVZp/HqrVwIbXRlFVNeNyTWR8TBqA9BUYl8vBuAkscOXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=t4c.dev; spf=pass smtp.mailfrom=t4c.dev; dkim=pass (2048-bit key) header.d=t4c.dev header.i=@t4c.dev header.b=bSOPBCtt; arc=none smtp.client-ip=17.57.155.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=t4c.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t4c.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t4c.dev; s=sig1;
	bh=852lip/wfJFnxoF9XrRiP8ZoG657RE218TpXlGdjgsY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
	b=bSOPBCttmm1Vtl8w4faw2ENmlVVp71RNdnItxubaRn+irAkZ2VJi3HR+OysXL5HMc
	 ngSd8Kb06kZkHE32Qn/9o/z6PaLDpZeZJk4xYVf6WK01MgodtVVndg+y34NBRJVpQo
	 KEvrHHfhHHE2qEQOivSWceIKwO7YVLXjQlPf1fE0+M97z+tkIToEkDBvUXMmTLsmZl
	 9XIs/ddounquBwLkcJMTpykU6vXIQvJlTZM3pvcnPQ4w6x1ie6R26hZVb2MO9Vcyo9
	 8sw2oOaUFeVp1jsXzmpziauQ4Drhd1EJLxFxvtmivDqONXhDYHf4GrlbS5KVfHvwlG
	 Lxmixqfvn3kFQ==
Received: from localhost.localdomain (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01072702.me.com (Postfix) with ESMTPSA id C5A661680104;
	Mon, 20 Jan 2025 08:53:08 +0000 (UTC)
From: Hendrik 'T4cC0re' Meyer <linux@t4c.dev>
To: ardb@kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@t4c.dev
Subject: [PATCH] efistub: add efi=quiet parameter to selectively silence efistub alone
Date: Mon, 20 Jan 2025 09:52:43 +0100
Message-ID: <20250120085243.2990309-1-linux@t4c.dev>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <CAMj1kXEeJattXAkvitfyu3KRRokkSMJZR0xgg_+DG2Mk-tMuoA@mail.gmail.com>
References: <CAMj1kXEeJattXAkvitfyu3KRRokkSMJZR0xgg_+DG2Mk-tMuoA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: lZmZTlnACRLFukfsgSQsb1HbsW-vDGSK
X-Proofpoint-ORIG-GUID: lZmZTlnACRLFukfsgSQsb1HbsW-vDGSK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-20_01,2025-01-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 bulkscore=0 clxscore=1030 malwarescore=0 spamscore=0
 mlxlogscore=558 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2501200073

> I'd prefer to just raise the verbosity level of those messages instead.

Agreed. I'll send in a new patch setting the verbosity of those messages one
above the default.

Hendrik

