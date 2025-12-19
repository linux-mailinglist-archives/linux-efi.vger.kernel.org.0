Return-Path: <linux-efi+bounces-5908-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 027C8CCF7B3
	for <lists+linux-efi@lfdr.de>; Fri, 19 Dec 2025 11:54:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FD59305934E
	for <lists+linux-efi@lfdr.de>; Fri, 19 Dec 2025 10:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07EC302157;
	Fri, 19 Dec 2025 10:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIkIwwPw"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2F33A1E7F;
	Fri, 19 Dec 2025 10:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766141406; cv=none; b=Yofj2UZO1U8ro8upChhicGNO1CaM5Cpi1JnHQn4N8d7Z8aV1jJhj+9rYAhQxwDBzVAfo2ukZ1iLLzISV25yqXDXXwdH9E090gJjM4O0YMw+Srx4PATIHjmNJ/rUEeSTNU8bwDKCypSPxC9EJUowUbKVQsFgiHbysSw27NFwpChg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766141406; c=relaxed/simple;
	bh=qlnsmk1hfgBCfkjAJgu3xnKFX5ByU2V866y+vzYYr3A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tbrI4dqKKdCTyzCK8vQQfpM2Ok6OKQSNanzI8pU4YUkdQLCxUHaiJJxVM7EvMZ6pBcRVnzpa3IYu3XI1OKRV/U6oaW8dEFmtAS6lcFkfq7euo2bOraUE7yAdzkecxWwx6MoSm7H3X7R222is/w4kLqMKtLB4OggQff7ko07bk8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SIkIwwPw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E09BC4CEF1;
	Fri, 19 Dec 2025 10:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766141406;
	bh=qlnsmk1hfgBCfkjAJgu3xnKFX5ByU2V866y+vzYYr3A=;
	h=From:To:Cc:Subject:Date:From;
	b=SIkIwwPwzPSonPZPwGbNEN+rQPmG0y61zEqbgPvLCvFKzBF7xfUSvaBqS2/avuMOD
	 6LJakwcfwsRKsKmNcM7TOjAM0Zmz2GIVAlUEHqkpsPe73n0rGH+8HPsqX2P2zHd++c
	 AoVVkfTGO19M+Y3meUWh8Wr9XUpCXJOzYoGxeux4xqtqsB7a2kL0RyDgSO3XN32t45
	 aUho6Aq472NlB2zqnEpMChWPJFA5rGGXjMvYfSkHVqOq+klUWi9xEbytY50YdJCk0q
	 78u0kYTbqeiZtOcZEXxEi7/ZiwPLxX3xNlRtLD/s1eLihsVpZ5ENahEVRCN+J/ZIxo
	 nf2TcXplleaFQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.99)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1vWY3g-00000005oL3-2KdW;
	Fri, 19 Dec 2025 11:50:04 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	linux-efi@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] apei/ghes: don't OOPS with bad ARM error CPER records
Date: Fri, 19 Dec 2025 11:49:58 +0100
Message-ID: <cover.1766140788.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Current parsing logic at apei/ghes for ARM Processor Error
assumes that the record sizes are correct. Yet, a bad BIOS
might produce malformed GHES reports.

Worse than that, it may end exposing data from other memory
addresses, as the logic may end dumping large portions of
the memory.

Avoid that by checking the buffer sizes where needed.

---

v3:
  - addressed Shuai feedback;
  - moved all ghes code to one patch;
  - fixed a typo and a bad indent;
  - cleanup the size check logic at ghes.c.

Mauro Carvalho Chehab (2):
  apei/ghes: ARM processor Error: don't go past allocated memory
  efi/cper: don't go past the ARM processor CPER record buffer

 drivers/acpi/apei/ghes.c        | 33 +++++++++++++++++++++++++++++----
 drivers/firmware/efi/cper-arm.c | 12 ++++++++----
 drivers/firmware/efi/cper.c     |  3 ++-
 drivers/ras/ras.c               |  6 +++++-
 include/linux/cper.h            |  3 ++-
 5 files changed, 46 insertions(+), 11 deletions(-)

-- 
2.52.0



