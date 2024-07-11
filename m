Return-Path: <linux-efi+bounces-1431-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A63BD92ED7F
	for <lists+linux-efi@lfdr.de>; Thu, 11 Jul 2024 19:11:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C930281263
	for <lists+linux-efi@lfdr.de>; Thu, 11 Jul 2024 17:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E4116D9A7;
	Thu, 11 Jul 2024 17:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X2qID9v2"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AAC15445D;
	Thu, 11 Jul 2024 17:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720717875; cv=none; b=tlX6VD4PGIeDypzuG2qdNIzlqGrIGzj54DRjyVpxaNGdfNqHllQ6atY0yj2Mx9numz/rPIxx2BAyIPY1wMkqV4j2RqOfavCqIyXgwT0QSUbQb/2BNEmiNQknD4dPZaisWSjmV9sGDkxpsR8+f6B/pRJtsJvv1atjgmiYOUSecB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720717875; c=relaxed/simple;
	bh=Kn7lxeI0ZZmou2Kjl6lW7oTqn17kXtcuO8fEU7YJnX8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=emGFiswzKeLJzGdx88quIUJXbUS+8V6lqEMkqvCeGfLmBPbrJ6fHSeqy+V1T+vc630QX/KJAmMK06nBKOM+EDb05/ZCEzV2MDWdQ8YETu5wMmbEASA4Kl09GREH5t3kvJYqsQA8F9sUf8gjVZt+GF9PN6zXQBUUAK8464XGPaFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X2qID9v2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75B7C116B1;
	Thu, 11 Jul 2024 17:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720717874;
	bh=Kn7lxeI0ZZmou2Kjl6lW7oTqn17kXtcuO8fEU7YJnX8=;
	h=From:To:Cc:Subject:Date:From;
	b=X2qID9v2iGUa6J6fQOPYtb8isZzxAFu2mKteBPtGpmJI0W6UWj/RpNN1cI81v6JnZ
	 Q2LGbHVJ0CqW4+8jzZLM4mauGiCBE4yhwAJjNHPayBh2WYAlXxacZ6Sgm7uPZgOvjY
	 eB1LA3XprE/7CJ3eU/OJ2DJ+QTIH8bYu3FXWIehQbFurLbHcchdEVYqeAu32z9FiPR
	 gzIcgYzHYlirih7V42I/zAp78DxodmV2SJ94mbV1XQro3Vl9yvsLDUgZscp0h7Fg/4
	 o+wBmexwjN6nLtCJyWubDFwPpy0oSq0FrFDFLfGdoFpHIWCtzoh8ky6ATBW5vhq+oV
	 5GRm+SHIQSfNQ==
From: Kees Cook <kees@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Baskov Evgeniy <baskov@ispras.ru>,
	Ingo Molnar <mingo@kernel.org>,
	Radek Podgorny <radek@podgorny.cz>,
	linux-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 0/2] efi: Replace efi_memory_attributes_table_t 0-sized array with flexible array
Date: Thu, 11 Jul 2024 10:11:11 -0700
Message-Id: <20240711170727.it.194-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=952; i=kees@kernel.org; h=from:subject:message-id; bh=Kn7lxeI0ZZmou2Kjl6lW7oTqn17kXtcuO8fEU7YJnX8=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmkBIwsYZ0zG0JibHl9qyLiouKR3mNODyxCguP3 gI4a89/+02JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZpASMAAKCRCJcvTf3G3A Jo2lD/9O8MQELlRwkRlVSXbtF3NnIsiQQ+S4CmKbEzBu3JN5Fx8tU7+U/QwJGCKEoKGgYZvDKiJ nnaccIGjzY1wPtyr6JU1fobWLrjnf7n7gl1HRsokrVGqSpI+ri+AgZGobis6u/qEZyt46hf3AuE kVo/t2+rvlJ/6rTB2j5cMFBViJ2Sb9wWd6fEoIqwP5k9LamxZl5Q6hijR7AALeWbX1I0s9bNg5w SGi6cnLHAswJVxYHEGIJ5g4OZ2mc72746OEUDptQVN2Y3HvOD1ybouUwTg9OM8ny+HxlnB6ZevL 40uR5lRrPPBkHFh1FW61T4J3xYRKJjOqF+6rd32i0notRxL4E75v6XO+Q1iFuQkXqHb3G6hwevG Gyl680KrtIKWAxknH+nB4ukZPFA6KhBeKYvHGRGNZsQa8rNvunYqRCI9tsCvA4APkk72oOhoVAq 8o9OxCbp9f4AA6T8ce7lNT2wHMBvSsK8n+R6GhZcKop7jL4ywM6vyCV+A9LNj5FnlbHNVvdsgof XlGkID+PhTvk3tvSeFyxJ1Z+AAYL9IhWTD8vJtOCxki/BInAkcmJqjCkARhvnEzzZGtmAMG9hgf wm9KyjWzHJmQLaWZKS0372zEHQvG4nJVyP+lRN/xro+JAVQ7ux50PJrP+EqVEvbDii7iJLdmhdm 9o/RI2rFD3H9KG
 w==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

Update efi_memory_attributes_table_t to use a proper flexible
array. Renames efi_early_memdesc_ptr() to efi_memdesc_ptr() so it more
accurately reflects its usage.

Thanks!

-Kees

 v2:
  - rename efi_early_memdesc_ptr() to efi_memdesc_ptr()
  - add comment about reading efi_memdesc_ptr() to efi_memory_attributes_table_t
 v1: https://lore.kernel.org/lkml/20240710225538.work.224-kees@kernel.org/

Kees Cook (2):
  efi: Rename efi_early_memdesc_ptr() to efi_memdesc_ptr()
  efi: Replace efi_memory_attributes_table_t 0-sized array with flexible
    array

 drivers/firmware/efi/libstub/relocate.c          |  2 +-
 drivers/firmware/efi/libstub/unaccepted_memory.c |  2 +-
 drivers/firmware/efi/libstub/x86-stub.c          |  2 +-
 drivers/firmware/efi/memattr.c                   |  2 +-
 include/linux/efi.h                              | 10 +++++++---
 5 files changed, 11 insertions(+), 7 deletions(-)

-- 
2.34.1


