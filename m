Return-Path: <linux-efi+bounces-1432-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEC592ED80
	for <lists+linux-efi@lfdr.de>; Thu, 11 Jul 2024 19:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71CF41C20D5A
	for <lists+linux-efi@lfdr.de>; Thu, 11 Jul 2024 17:11:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CF7F16D9B5;
	Thu, 11 Jul 2024 17:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nNjprgW/"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C93A16D313;
	Thu, 11 Jul 2024 17:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720717875; cv=none; b=oCoC9M+sZx1Nqm7IuvsUFZh7prML+m610skDReTOqPWOvUEaeRdhchlR8I8bKXQ0retw8LH0ZdJLOl7YRl9ZIE4zaOKQwPUARY8nGb5YllW2RRn5zP5MDDoeP89BHcZRapVHAy/HrNTVb+6BDhX+Kq6gGNhnkmj0A6mrvEnb6hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720717875; c=relaxed/simple;
	bh=PnCjovdovXk9cCG240pvFyOatuK6fCFNWcfBvIcgqTE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ESH799+GaSdntfv2M0APgeFK/OFUd/vlzDqZ9jGSIPjlOQysJjrPfZKTEvBf28oisks2X3o2KC3BPbzrIOeL9fZeulmbdZhZUONHwBc7yHKV6lvs0zn+1nf0zbcJobIx7e6PM8Tml4VMY3Ep0OviaQo3VGxnRjBy987jw4ubt2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nNjprgW/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0B5C4AF07;
	Thu, 11 Jul 2024 17:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720717874;
	bh=PnCjovdovXk9cCG240pvFyOatuK6fCFNWcfBvIcgqTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nNjprgW/2jpNHNaDpcjA4OnmlFkC5G1rvr/2uDzwRpP01/JEDwupaQ/Y+ONE1kgwG
	 CaJ35xc4Vza09SZ8iu8BkCr/jW9hSFWZUgGlRVMJfGM7T7kVU7cxxgt0APVajZeZLb
	 zb0tHYRruSW+ix6stIHsUEK6J3lWpdNYroF2VJtkah5Gg35336fOaCXeNgakb7UYiG
	 ZY/gihcKITUubrCKxfdMTvY5PYB7fjqiUkuYkZR7inh3edid8w/JbnGYIyVrqv2FCd
	 aijKZgHxiO+iIv5YNhiHYsFvbGszFFqQJbTDUnu+HWNbwYwABjKri+6617YArDW0Ff
	 KhLOQQ4Hj5G4A==
From: Kees Cook <kees@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Kees Cook <kees@kernel.org>,
	linux-efi@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Baskov Evgeniy <baskov@ispras.ru>,
	Ingo Molnar <mingo@kernel.org>,
	Radek Podgorny <radek@podgorny.cz>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 2/2] efi: Replace efi_memory_attributes_table_t 0-sized array with flexible array
Date: Thu, 11 Jul 2024 10:11:13 -0700
Message-Id: <20240711171114.121313-2-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240711170727.it.194-kees@kernel.org>
References: <20240711170727.it.194-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1748; i=kees@kernel.org; h=from:subject; bh=PnCjovdovXk9cCG240pvFyOatuK6fCFNWcfBvIcgqTE=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmkBIxTZOLrENfCsAvyVVDL8bZ4k0hY9cZ8bQnc IzNZMEQ/S6JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZpASMQAKCRCJcvTf3G3A JnOmEACGwHHHeKkIjpVqzImdgW7pYpvw2dwfpQXro7NiYCbZRan+muQ5C+LH10AwVGFwwNBykvi 4d4qAtUUeMWQaTWxqxgrgrpL4ZDtPVgJxLNqbQ+Wz9I9QoOJuJgxAxKjUbhywqTkJ//0Sfe8Njr LIQb3jzTyjRtCYFffwT5MWrqImyIEAvGtRGDFkOzGwEacT/nUi17eqTc5iVBhwf4dsuAYQiW+Ue TsBLrScfZkKPifyuL1ncWoQskj66zU6POtYcjAVRkbCP06Y2hIyhUThwGzWRfrMu4N02JYD5i2W q1rzsIyqW97mZjz9IsqRDMYpjWjCttw1RaiNeXQzKCiMBA+dLOrCuV+RFv7LQq2/q5V4AUVLN1j /lfegKZxCb15Gcmq7FZvN1LiIdCZWNIuTLjHHq1tRXlX6nvEf3xtnxLZfDqo2pLrBUSsMZWYzsg Wj4dTsu5t6dhCCj4l3SdPXHoFDynqKzYQ3h/enYhilEUDmHwukphqY91Vsk10Rq8DOIRtyKqLBo sG9ORcmuFS8KPomMzW54JOZbYMPVliMVV/tCTQWGkHimYtXmQccdTW7FdFP6GIO6gBHwsF1ozMl vKqzXz1pyj+48rvbwDxP2Af5IV8LVm3NioYq93fL0BfEJ8/rAgZ4Su9gvWVpNiq+bJPD/Qo5Ii1 sZWkESA7YjCwTew==
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

While efi_memory_attributes_table_t::entry isn't used directly as an
array, it is used as a base for pointer arithmetic. The type is wrong
as it's not technically an array of efi_memory_desc_t's; they could be
larger. Regardless, leave the type unchanged and remove the old style
"0" array size. Additionally replace the open-coded entry offset code
with the existing efi_memdesc_ptr() helper.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: linux-efi@vger.kernel.org
---
 drivers/firmware/efi/memattr.c | 2 +-
 include/linux/efi.h            | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/memattr.c b/drivers/firmware/efi/memattr.c
index ab85bf8e165a..164203429fa7 100644
--- a/drivers/firmware/efi/memattr.c
+++ b/drivers/firmware/efi/memattr.c
@@ -164,7 +164,7 @@ int __init efi_memattr_apply_permissions(struct mm_struct *mm,
 		bool valid;
 		char buf[64];
 
-		valid = entry_is_valid((void *)tbl->entry + i * tbl->desc_size,
+		valid = entry_is_valid(efi_memdesc_ptr(tbl->entry, tbl->desc_size, i),
 				       &md);
 		size = md.num_pages << EFI_PAGE_SHIFT;
 		if (efi_enabled(EFI_DBG) || !valid)
diff --git a/include/linux/efi.h b/include/linux/efi.h
index fbdfcc9a81e6..40475d77231c 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -607,7 +607,11 @@ typedef struct {
 	u32 num_entries;
 	u32 desc_size;
 	u32 flags;
-	efi_memory_desc_t entry[0];
+	/*
+	 * There are @num_entries following, each of size @desc_size bytes,
+	 * including an efi_memory_desc_t header. See efi_memdesc_ptr().
+	 */
+	efi_memory_desc_t entry[];
 } efi_memory_attributes_table_t;
 
 typedef struct {
-- 
2.34.1


