Return-Path: <linux-efi+bounces-479-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55132849D53
	for <lists+linux-efi@lfdr.de>; Mon,  5 Feb 2024 15:45:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 887EB1C24BBB
	for <lists+linux-efi@lfdr.de>; Mon,  5 Feb 2024 14:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B96376E1;
	Mon,  5 Feb 2024 14:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="IqH229K8"
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2EE33CF9
	for <linux-efi@vger.kernel.org>; Mon,  5 Feb 2024 14:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707144293; cv=none; b=O7uIYPiMAaI+lJdC+rKQl3kiytl9cwoM1waWZcceHepFt4Q/khF4HvBiCb8e0Lm6fbnlvkD/tMSeIOBA9LeclzH9gRs8xUngzIxnCtwjBLel5S88riehPKFKBONdFQ/tlIAU1/7a/fNF9BK2YdW3KMwyjLGgeaI1B+lf8BLA3Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707144293; c=relaxed/simple;
	bh=zP6TX4xl8CRbLHRfwB1A7PK1XvlKbHZJUeioL5NZFz8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A6AoyYc/BChnxagkuqN75u/exDLOZ5Nay8sM+mRhRS3b7X5W6aP60IguWVTsIhcv9kifhTI038t2R6MCei3Bz+FHh6tpN8dkNjpVbUTiMtWk3cDKxV0MROIEAgdN8PAIiRG4f7oKP7VNVpiYXf/XZgiZYGJ6ANgp3uSDvGhO5j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=IqH229K8; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from localhost.localdomain (unknown [80.240.223.29])
	by mail.ispras.ru (Postfix) with ESMTPSA id 57DC040755C3;
	Mon,  5 Feb 2024 14:44:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 57DC040755C3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1707144288;
	bh=bq9Y67Wahhp63+cPOtzktnA2Iw7DJ8iYr3k4nwjft7E=;
	h=From:To:Cc:Subject:Date:From;
	b=IqH229K8vDHRPArh28XzxApkzouYTpYt14+0PC8cjahBvZkqg/qhJVnRWlWmXkN1k
	 Sd7SsZOT7MLNHgpUhtAiidq0jf+Q+hBKJafRegIF/2hs3GGElOk9221M56FrZn5GWv
	 nWXXByqcxEUhySSGtgIrIT2VeCVc0c1PNvIHcDDM=
From: Evgeniy Baskov <baskov@ispras.ru>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Evgeniy Baskov <baskov@ispras.ru>,
	Mike Beaton <mjsbeaton@gmail.com>,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	linux-efi@vger.kernel.org
Subject: [PATCH 0/2] x86/boot: EFISTUB section alignment
Date: Mon,  5 Feb 2024 17:43:59 +0300
Message-ID: <cover.1707141974.git.baskov@ispras.ru>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I had these patches fixing [1] laying in my local branch for a while.

The key problem was that sections were not in the same order in section
table as their VMAs and the '.compat' section virtual size was not
aligned on section alignment.

[1] https://lore.kernel.org/linux-efi/CAHzAAWQ6srV6LVNdmfbJhOwhBw5ZzxxZZ07aHt9oKkfYAdvuQQ@mail.gmail.com/T/#u

Evgeniy Baskov (2):
  x86/boot: Order sections by their RVAs
  x86/boot: Align .compat virtual size

 arch/x86/boot/header.S | 58 +++++++++++++++++++++---------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

-- 
2.43.0


