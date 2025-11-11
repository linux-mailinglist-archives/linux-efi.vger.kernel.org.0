Return-Path: <linux-efi+bounces-5407-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A59F4C4B958
	for <lists+linux-efi@lfdr.de>; Tue, 11 Nov 2025 07:02:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC1DC3B783A
	for <lists+linux-efi@lfdr.de>; Tue, 11 Nov 2025 06:02:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E5F924BBF0;
	Tue, 11 Nov 2025 06:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Xprq7x27"
X-Original-To: linux-efi@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC9316EB42;
	Tue, 11 Nov 2025 06:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762840936; cv=none; b=f8i03s6k2wIEHHaPjh9tv3bSyDfVoL9seAgMlj+RQOdIiXbzwHWlaVpMxA+JHlogWWtnhc7XoGitRsNe4/W1Ey2ApoigQA1S97heuuTLueD/DTi/1w9fnBKpclsxNCkvBKZufMOr3rMj4ie6SefUeeuTm3YkqhloDFfUBMbnvq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762840936; c=relaxed/simple;
	bh=FdJwL9JSzwV4UQQXRcpSy17j+YswctMS26lIS9FG4jA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FahNCDmIcwkGAg2dT6fEjuiT5iFDgakdPbZ9w6W2EXtlTaXvjH7MgK4EXMlmcfcqmswObQmbOwQSh4rr674OWhElM9xIyyjKlTReWHM5mx/y5dOzRbJRE0J+gNUb5DmGkQnxM8PGzr9fDcJxW5M20b2JqZaDnx5z+8cIc7y3elo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Xprq7x27; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=9FvSxcETb6qmgterhtVgRWeeCLevVfNPooXzwD8lXTQ=; b=Xprq7x270sJOgieEKEkVQ+sgKa
	FQr+nKFZvlGxFGbquPIjpeQQiQxu7kHBsK7svtF4ZZKH+JtRcDmF6XoupbilVC0trVcAfjyxMZAIM
	f+l6oeoKlDQWqryeDDvUbaRYtd/fWkPtvcM07RT6VTA/jsFDHz/zNzoMx+Xp1bWphPv33maFW4Kii
	IEOw826/4An5UPNkaaxFcdgTRKURamT5gUvdlbDIGKY6+QfQsC+to1NyL5Dy0wn4hYrIMpFPx/gt6
	FD8q8/G72zCSA8+17iTlqyop8/HCv7IPJKWHfWh0QgqNs5I9rECTP4Z1a3RT2HSuGos8CklizTsd4
	PjFUD9Ng==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vIhSH-00000006aaj-0cs8;
	Tue, 11 Nov 2025 06:02:13 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	linux-efi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Subject: [PATCH] efi: stmm: fix kernel-doc "bad line" warnings
Date: Mon, 10 Nov 2025 22:02:12 -0800
Message-ID: <20251111060212.1963608-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a beginning " *" to each line to avoid kernel-doc warnings:

Warning: drivers/firmware/efi/stmm/mm_communication.h:34 bad line: 
Warning: drivers/firmware/efi/stmm/mm_communication.h:113 bad line: 
Warning: drivers/firmware/efi/stmm/mm_communication.h:130 bad line: 

Fixes: c44b6be62e8d ("efi: Add tee-based EFI variable driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
---
 drivers/firmware/efi/stmm/mm_communication.h |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- linux-next-20251107.orig/drivers/firmware/efi/stmm/mm_communication.h
+++ linux-next-20251107/drivers/firmware/efi/stmm/mm_communication.h
@@ -32,7 +32,7 @@
 
 /**
  * struct efi_mm_communicate_header - Header used for SMM variable communication
-
+ *
  * @header_guid:  header use for disambiguation of content
  * @message_len:  length of the message. Does not include the size of the
  *                header
@@ -111,7 +111,7 @@ struct efi_mm_communicate_header {
 
 /**
  * struct smm_variable_communicate_header - Used for SMM variable communication
-
+ *
  * @function:     function to call in Smm.
  * @ret_status:   return status
  * @data:         payload
@@ -128,7 +128,7 @@ struct smm_variable_communicate_header {
 /**
  * struct smm_variable_access - Used to communicate with StMM by
  *                              SetVariable and GetVariable.
-
+ *
  * @guid:         vendor GUID
  * @data_size:    size of EFI variable data
  * @name_size:    size of EFI name

