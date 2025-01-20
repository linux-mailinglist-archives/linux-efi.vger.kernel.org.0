Return-Path: <linux-efi+bounces-2690-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BEEA168F9
	for <lists+linux-efi@lfdr.de>; Mon, 20 Jan 2025 10:13:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C933166311
	for <lists+linux-efi@lfdr.de>; Mon, 20 Jan 2025 09:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F50195FE5;
	Mon, 20 Jan 2025 09:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t4c.dev header.i=@t4c.dev header.b="gopeAN9l"
X-Original-To: linux-efi@vger.kernel.org
Received: from qs51p00im-qukt01071701.me.com (qs51p00im-qukt01071701.me.com [17.57.155.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7563B199EA2
	for <linux-efi@vger.kernel.org>; Mon, 20 Jan 2025 09:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=17.57.155.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737364430; cv=none; b=aY5f3jYtBjrhYUpCs+4mwHyNVrwF2swU4BaW9OyaX50BQ5DKVsK6fuyKWdEt7mxEu9UY3RDBbC3BdWuMamoETBMoOyxWKDv3lx1k+fqsqRzBMhIj3+lVQevw9dxgK/4JVAepV+pRyJ10Z/DQXt4JGPbg3lr4yTiw5RBbDtVp5lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737364430; c=relaxed/simple;
	bh=C3pnz4Krp14CkRiQ74xYZiFhIt2rRqhYmfkX6NrQHl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ce/kGn3f9MVQG4LlhObXO6aQJCEu3CZwUlHp31Bjcb4YZew0m2jX6rpgqTm7WPtyxz9Ft3aKyq7bqXJNnJcVuxI+OA4BNoL7enWtpgz8RFbmnrbiu1lepPXnRFNsWyrjgbRhSl10OvTi4OhuekDyzg6FwSJXdNmc5ZiU94JWv0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=t4c.dev; spf=pass smtp.mailfrom=t4c.dev; dkim=pass (2048-bit key) header.d=t4c.dev header.i=@t4c.dev header.b=gopeAN9l; arc=none smtp.client-ip=17.57.155.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=t4c.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t4c.dev
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t4c.dev; s=sig1;
	bh=C3pnz4Krp14CkRiQ74xYZiFhIt2rRqhYmfkX6NrQHl8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
	b=gopeAN9lwXymzJs1wW+3ECoJK+xDJnkkcSSaeHjAXxFPP8sQlVjwCp/9lxneqUefo
	 16Aw/0XJAioO6DMUmSvEs65IQBz5kiOG6OLtBpP2So1ADp2Rtrqhdw/0LUclqq4ZCb
	 u0yGHKnTu1zwqio1sz9NDnmuDWxwguWE/1R3iEIlQteRDb1x8Ew9znFW44GheAz9xg
	 u47faL8s84EJLLLxtvgep+yDyRhIAwhUlmhFk4cAU06T0zRNbxCZstHgReH5YmY5Em
	 WS+03jtY4gBOYaWB7HsujOT3CdltAWDmzFh1B85GQOlTqHpoSwVIc2u8US+g+1kxAa
	 7yz36B/aZBcGg==
Received: from localhost.localdomain (qs51p00im-dlb-asmtp-mailmevip.me.com [17.57.155.28])
	by qs51p00im-qukt01071701.me.com (Postfix) with ESMTPSA id DBD724D001E0;
	Mon, 20 Jan 2025 09:13:45 +0000 (UTC)
From: Hendrik 'T4cC0re' Meyer <linux@t4c.dev>
To: ardb@kernel.org
Cc: linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@t4c.dev
Subject: [PATCH] efistub: add efi=quiet parameter to selectively silence efistub alone
Date: Mon, 20 Jan 2025 10:13:35 +0100
Message-ID: <20250120091335.2992309-1-linux@t4c.dev>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <CAMj1kXFKSrVx4SO_T8sHU=4hie8pjk8CUWQDV8oh+bz=xMn4rw@mail.gmail.com>
References: <CAMj1kXFKSrVx4SO_T8sHU=4hie8pjk8CUWQDV8oh+bz=xMn4rw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: KtTpKe7jAJuCaQsMpBJtZ4NyI6PTAv36
X-Proofpoint-GUID: KtTpKe7jAJuCaQsMpBJtZ4NyI6PTAv36
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-20_01,2025-01-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=646
 spamscore=0 phishscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 clxscore=1030 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2308100000 definitions=main-2501200076

> Does the below work for you?

Assuming 'efi_puts' logs as INFO level, yes. That should do the trick as well.

Thanks!

Hendrik

