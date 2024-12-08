Return-Path: <linux-efi+bounces-2316-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 200E29E8751
	for <lists+linux-efi@lfdr.de>; Sun,  8 Dec 2024 19:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B4B916452F
	for <lists+linux-efi@lfdr.de>; Sun,  8 Dec 2024 18:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C90A187859;
	Sun,  8 Dec 2024 18:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="lIw3meQq"
X-Original-To: linux-efi@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6323A145324
	for <linux-efi@vger.kernel.org>; Sun,  8 Dec 2024 18:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733682874; cv=none; b=JE+Zy0Y0YFZhQCnTM81mr/KeXDT0Q0r/5B5ZBpsg4lBNSfvOI6FGwZulFw5+H5mI4eeh3GaNQ8c0Af9EHqAADy71/tVEWYkmtls6EtCNmcaOZClpqu76/uDddmY62tObubC2RuTAzRBzfFd8UQiYQCFt2Muxhr114P91XNYxwFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733682874; c=relaxed/simple;
	bh=CEFbQO9WoUWjQ9yZuzLZ2S94EPhn+Z2/LJiAODcYJvo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=H+b3a3lNwHPB+/c2l92+sold9enyci2NA9NJBSQdRdAq3ZFzWfo/hWuPKJV/jic+jpzVGp3DSZPu73WABtXDDE+RuWcn3rzOsqTdqU7G20t/xtSni9bH8EKbnqBESzyUd+pHh6TsnmgJIiJwLXryNjggspyjB2cYprh9yOm6gjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=lIw3meQq; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1733682869;
	bh=CEFbQO9WoUWjQ9yZuzLZ2S94EPhn+Z2/LJiAODcYJvo=;
	h=From:To:Subject:Date:Message-Id:From;
	b=lIw3meQqnAqRvyOtEaFcku5Znu4TO3lKOhhdotjopWc2MdzQsIAAe9zi9J9/0CWAC
	 IruButYpTTRHBkFo6V8BsO6TCUbA+VnXCBxcp8ffsIW3+G6slZK+qg6paNEZbS4Bqe
	 6GHhfboTdjILOjOxWWc488CtbMzXudkL6R057H6Y=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id BCBD11286D0B;
	Sun, 08 Dec 2024 13:34:29 -0500 (EST)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id eVwlL2MnwyCp; Sun,  8 Dec 2024 13:34:29 -0500 (EST)
Received: from lingrow.int.hansenpartnership.com (unknown [153.66.160.227])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 32F5F1286D4F;
	Sun, 08 Dec 2024 13:34:28 -0500 (EST)
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: linux-efi@vger.kernel.org
Cc: Jeremy Kerr <jk@ozlabs.org>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 0/3] efivarfs: bug fixes
Date: Sun,  8 Dec 2024 13:34:12 -0500
Message-Id: <20241208183415.21181-1-James.Bottomley@HansenPartnership.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 is stand alone, but 2 depends on 3

Regards,

James

---

James Bottomley (3):
  efivarfs: fix error on non-existent file
  efivarfs: fix memory leak on variable removal
  efivarfs: fix incorrect variable creation

 fs/efivarfs/file.c  | 30 ++++++++++++++++++++++--------
 fs/efivarfs/inode.c |  1 +
 fs/efivarfs/super.c |  3 ---
 3 files changed, 23 insertions(+), 11 deletions(-)

-- 
2.35.3


