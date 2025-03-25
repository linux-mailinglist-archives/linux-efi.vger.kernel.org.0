Return-Path: <linux-efi+bounces-3083-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6336A70566
	for <lists+linux-efi@lfdr.de>; Tue, 25 Mar 2025 16:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57E58188CEEF
	for <lists+linux-efi@lfdr.de>; Tue, 25 Mar 2025 15:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F89253B41;
	Tue, 25 Mar 2025 15:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cn6hlADy"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9392729408;
	Tue, 25 Mar 2025 15:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742917543; cv=none; b=QihRNIreegX/d3ckfBTObbSbFdRU7Toykmz3pZ7xx9HLXkF7ximf1ST0sYMI/E4+8p4SEx8DlHsPCELEhMjqWCLlVG+WV7PAAheabzGr8CiQo9EORffJ1lc10R5LSzKjAF7iXi4HtrMncleN8mxzkCmI6T+gjiA7fZphMY4fdtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742917543; c=relaxed/simple;
	bh=EmbT1j95ZQlEX79VYjHMceTDJmKdtuHVQmu6wl1izBc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=T+/kVoGXhmmK6MdCtVUtETJonPJTLX7yPTJfboGFDrzKBxZ8aMt480SMLfGAr8cp7dvMB++KN8eREg1BHJWDANFgpKfq7tXOi67dYRKe2FAVDe5Sg+oR0qwJUjDUkvt3ht3olGrZRShZ4ozi5QK6+lLDy2EQ9rRaf0n3F3TcES4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cn6hlADy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8AB6C4CEED;
	Tue, 25 Mar 2025 15:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742917541;
	bh=EmbT1j95ZQlEX79VYjHMceTDJmKdtuHVQmu6wl1izBc=;
	h=From:Subject:Date:To:Cc:From;
	b=cn6hlADy45e95gGtO2Uas/mCsaTF9UXYTXZmLjJKW5iCNe4N/zMTdP75HRqK5HHl7
	 w1mFxMewMdzQIClzTgod+/+f3OueAncrkt9uQT2jH271X0bsY9BGBM0Ll2lKYvP38+
	 MXTcmufY468yAaRQJrxe0rF0HQF54QXcAWPTzosqEzbWiYw5nmI8XOedpbwGwptyk5
	 LVwZ2vUrJL2QWZzY5x83TAeeMe+wV1VVTyovXf518Y/uNYd0n1//DZFR2FJZwT2bJ6
	 m7lpyaz9BTz0IW4I+2p+XGPBMXeAYBaDH+npjEQQCWmsn1XSlCou0mQ7k11bp66LDn
	 tLbIFkObn75qQ==
From: Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 0/2] string.c: Add wcslen()
Date: Tue, 25 Mar 2025 08:45:17 -0700
Message-Id: <20250325-string-add-wcslen-for-llvm-opt-v1-0-b8f1e2c17888@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAI3P4mcC/x3NQQqEMAxA0atI1gZqVUSvIi6cNjqBTiuJ6IB4d
 4vLt/n/AiVhUhiKC4QOVk4xoyoLcN85roTss8Ea25raNqi7cFxx9h5Pp4EiLkkwhOOHaduxM23
 XV/7TW2cgRzahhf/vYJzu+wF52/OvcAAAAA==
X-Change-ID: 20250324-string-add-wcslen-for-llvm-opt-705791db92c0
To: Kees Cook <kees@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Ard Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, llvm@lists.linux.dev, 
 linux-efi@vger.kernel.org, stable@vger.kernel.org, 
 Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1097; i=nathan@kernel.org;
 h=from:subject:message-id; bh=EmbT1j95ZQlEX79VYjHMceTDJmKdtuHVQmu6wl1izBc=;
 b=owGbwMvMwCUmm602sfCA1DTG02pJDOmPzi+abfrzlvaVKNNg1brL545ZhTSszvigyqZ6zEzyR
 yvrs3aLjlIWBjEuBlkxRZbqx6rHDQ3nnGW8cWoSzBxWJpAhDFycAnCRX4wMs6e8PPE3Tv0+/zrx
 y4/fcJ1JOZmjELapOqF0WmeO2TbDqwz/A7KYLgvpWdWKdL9Kzbdx05cS9zG7am203oyhJZRh0T8
 +AA==
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716

Hi all,

A recent LLVM change [1] introduces a call to wcslen() in
fs/smb/client/smb2pdu.c through UniStrcat() via
alloc_path_with_tree_prefix(). Similar to the bcmp() and stpcpy()
additions that happened in 5f074f3e192f and 1e1b6d63d634, add wcslen()
to fix the linkage failure.

The second change is RFC because it makes the first change a little more
convoluted for the sake of making it externally available, which may or
may not be desirable. See the commit message for more details.

[1]: https://github.com/llvm/llvm-project/commit/9694844d7e36fd5e01011ab56b64f27b867aa72d

---
Nathan Chancellor (2):
      lib/string.c: Add wcslen()
      [RFC] wcslen() prototype in string.h

 drivers/firmware/efi/libstub/printk.c |  4 ++--
 include/linux/string.h                |  2 ++
 lib/string.c                          | 11 +++++++++++
 3 files changed, 15 insertions(+), 2 deletions(-)
---
base-commit: 78ab93c78fb31c5dfe207318aa2b7bd4e41f8dba
change-id: 20250324-string-add-wcslen-for-llvm-opt-705791db92c0

Best regards,
-- 
Nathan Chancellor <nathan@kernel.org>


