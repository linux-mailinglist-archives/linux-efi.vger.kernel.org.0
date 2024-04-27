Return-Path: <linux-efi+bounces-997-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE7B58B445B
	for <lists+linux-efi@lfdr.de>; Sat, 27 Apr 2024 07:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 024EA1C2208B
	for <lists+linux-efi@lfdr.de>; Sat, 27 Apr 2024 05:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07023FB2F;
	Sat, 27 Apr 2024 05:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="tIwLi7UW"
X-Original-To: linux-efi@vger.kernel.org
Received: from out203-205-221-209.mail.qq.com (out203-205-221-209.mail.qq.com [203.205.221.209])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84163EA96;
	Sat, 27 Apr 2024 05:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.209
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714195719; cv=none; b=Bz0m0zIWc9Ll5HvXF25pIB2PNEvZYy7Uu0uuufNVEYsiswljeDb6N2mxhxMXcMHqHo3IByuWq9WrLzka8IliVqMVjh5Q+6+LYkD/FQpsdXhGV1cSOFzJRhcTXqosgGnCNSPKvqbSu0PBJ32sQueoU9kfYBg+odoy0VVSFdyl9+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714195719; c=relaxed/simple;
	bh=GwqpKC5+LkRLRTZ4RlLT13C4t8nOGVEKrN3Cl/Yjgm8=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=FJZMuL7oySwVzVK6WaAr2gUwd+tAMVYJ7mJvcsw13s8WTE/kkEPxxgOrGjSYSv2tb8hsS/VkLRQmfYbefRBSreRBEzs/RPotkUN6bJoGLdUZ3zb2EbBZGh4Wimcv8RKNs05UqbWDRHx0rqu7TDFEamt9ZxKYenQX4nFvfkLRCs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=tIwLi7UW; arc=none smtp.client-ip=203.205.221.209
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1714195704; bh=OPRLB2fvbwGnGWhWWCaQT4aiVsrtxUso4PGORBObRx0=;
	h=From:To:Cc:Subject:Date;
	b=tIwLi7UWenf68TtvO8RZqWj61IASgk3P7bsMXQXAq358VYQkQFI/rHNvii0zFerBb
	 JWNFn/V4U8EiXSQD2jK8kbGxTHWVTqaZiqAHI7TBhtLUsSumTgZjCNPqXVr08VM4jb
	 hO9vP/gY0YZVdtZUlF7x9lyjFQGOWbjRmCzz3OFo=
Received: from localhost.localdomain ([58.213.8.145])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 649974F2; Sat, 27 Apr 2024 13:25:09 +0800
X-QQ-mid: xmsmtpt1714195509tnziqak7s
Message-ID: <tencent_E910110547D287B13FEDB6E161D8874E6E06@qq.com>
X-QQ-XMAILINFO: NMGzQWUSIfvTorIFbPMI2XNbz0tgf4ZkeLxSeVT6T+LxYTX4HeP/Fm/R64o4ie
	 AHoK3qD2FK+DKjsvGmtc+XmK11Spn/YvDtY6lfrkYBu7KeQV+EE9WUYg2kZw/MmCUUmOgbUZ9/O7
	 Rl2U/CsEjoCJEtucuikX4OB6L/IuNiMLtgRU9Fk8CGLrsIvuoQdCM106qVneT/claNqKvQSwXNNc
	 v32sGYOYrD/nvoQGjEwRnNEWt+EINwK/k66fwaKOer+d1Shaa5ZJ/H/Bbb0mEaEpFClgEDDa6vm8
	 z985LRVxZ+VABus2/qju9LDVLSSP3hq9LnmlIunv/eb1b8LGlAr5wCwi7N8OQI/kXEtQu3AfyGvu
	 ChDM5ObRRg7zy7Q+EnIxzekMG52emLLPpRuOx1X8EO184yvbVYXj5fCzACX8LygFSeUzAaoKigR7
	 YM/R5ZGWGBjIZzYELrbI2FOGSOUzEbkBwc0VQjCL4T6D56oXnfnHLduHq//61mTRGiqohvQprUN9
	 uvPEKEYCoEKPCu4ta2b/FHxV3qWniB2ZqA6fsh4IRB5UutDA1++KSoclqH231puFFPLbmEn9ExLu
	 zkqXoP5mFZH77QGTKbG7lz553opN5G1uSS0aGlmyj8TVnf/HdMR3IpKP8c3EGuaJnUHpjGQX6/iF
	 JUGyo1ZfK5yp5giGICR7EHP5WV+CNoFtA6nNh079ZwTDk1nnrLO/1+uztbIr5A4XRXB0hwE+2h+c
	 1rTIBoBOBBYknpXLBKOU1RGivBFq9DPuIplSTmmKLA9lAS/u2HYEKzzg8XfwBYQ5qVntoriRnJ7R
	 rQTV50uV6/DUE6CsOaPL7wtbpr5yXphZe/91Hw5rbqT+dnc4rQ77fiwi8opFbyDbWiISWuY0IFvG
	 0gSHfiseMf8iP9eEkSB6+DbPNjNK/XiKaUNyOiib5hUqaMISqdUM0LW/tvZYumhGQZYW9oH8koqk
	 qscSm7RWamV+rxXuNRFYHUS7U8YQToE8nOdXlCx7cZ/vo8VttRGnsVegynYj2ildEsY/P1ims=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From: linke li <lilinke99@qq.com>
To: 
Cc: xujianhao01@gmail.com,
	linke li <lilinke99@qq.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-efi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86/efi: mark racy access on efi_rts_work.efi_rts_id
Date: Sat, 27 Apr 2024 13:25:07 +0800
X-OQ-MSGID: <20240427052507.29801-1-lilinke99@qq.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In efi_crash_gracefully_on_page_fault(), efi_rts_work.efi_rts_id can by
changed by other thread from the comment. Mark possible data race on 
efi_rts_work.efi_rts_id as benign using READ_ONCE.

This patch is aimed at reducing the number of benign races reported by
KCSAN in order to focus future debugging effort on harmful races.

Signed-off-by: linke li <lilinke99@qq.com>
---
 arch/x86/platform/efi/quirks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/efi/quirks.c b/arch/x86/platform/efi/quirks.c
index f0cc00032751..4acb81700caf 100644
--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -751,7 +751,7 @@ void efi_crash_gracefully_on_page_fault(unsigned long phys_addr)
 	 * because this case occurs *very* rarely and hence could be improved
 	 * on a need by basis.
 	 */
-	if (efi_rts_work.efi_rts_id == EFI_RESET_SYSTEM) {
+	if (READ_ONCE(efi_rts_work.efi_rts_id) == EFI_RESET_SYSTEM) {
 		pr_info("efi_reset_system() buggy! Reboot through BIOS\n");
 		machine_real_restart(MRR_BIOS);
 		return;
-- 
2.39.3 (Apple Git-146)


