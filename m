Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B079134452
	for <lists+linux-efi@lfdr.de>; Wed,  8 Jan 2020 14:54:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727610AbgAHNyW (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 8 Jan 2020 08:54:22 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:36607 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727456AbgAHNyW (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 8 Jan 2020 08:54:22 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1Mbzhv-1jPbrj0pFX-00dWzs; Wed, 08 Jan 2020 14:53:52 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ard Biesheuvel <ardb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        James Morse <james.morse@arm.com>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        linux-efi@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        Enrico Weigelt <info@metux.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] efi/libstub: x86: fix unused-variable warning
Date:   Wed,  8 Jan 2020 14:53:42 +0100
Message-Id: <20200108135350.3861390-1-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:mDOgQrgpp8JFhnM8YGVdFOjza1NZGBT6P8dACCvyHENm9LwkuuC
 +fMB3K2i5+HK/cfJPQZLG/yHUZCckLdBQ/I+zRUx9oD8ZfOE60nN+4V5r4nUJ2S4cz/zc3J
 2HBrMQVXu1qvLklmat/PzMjKJ+Iucla/BE+9Y3RPSVyJLwqGLgR6mxjhGcq1/u7OBb85Jso
 /n+cHR0zJ91oWAfAkPGQg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:oceIgk8RTxk=:jtOQSxqHZ4VH8LM9GSzJ+z
 KTh5wwmnculFytq8jEuKHMDMGarGnc37t6SFDQgdy7QubvaTqEAFLJ65/do4lQvFIOHMjg4C8
 c5TkC8JaViOo4YKv6FjAqs3DkBb7QT/3TY+HW+LZQnsrJh1ajKCH0pa4m5vDXJ/7cZnaKWEZw
 MV0064yTDjcSzszuEn9RPpfh8uH+Vk00S2q6LLKGhONCr1lVFwND0Ylg7kprbLkjdW2dqz8xC
 e/DxTIg6yIBcWAwOzlQM/M4JpJNMgZFbGKR3aZuy25Vw816nRD9Wx/xVskKWSRwXGLhyvdq1G
 EquAlS75/VpuGHutE1Hk2tAo2+SjdYEBJ+0oEukC3cqntiJ4vy0E1qjHljU8D1YPEWtoGSDqE
 nVVssPaF2VzzmTBTcYIix41xNlSflEr68BmYpBJMinqpktXp/U2C66juENDtG2n+a/5NCOolx
 +7YXL1VRicIh94kqau6GkvlOAx6SlAZbf/EYJytJiNGY8omfWneWD9KE4XVySAUOcUwqMaXX8
 S3CnhRql69blBn3ln8h4fdSg35DycJlbPs7ToDR6gqFyFG3nYIaSgOp8oS4hs/D5p5FXXtBBp
 NUWT7QyWK/e/q5XvmgatDgOFV1mFrc0r6Rko30++PBk3EMB7zdISFBshXxtLRn/GSLB5HaABE
 wmL3O2HD0OUwVletwoPEWJxsHXnXaBIk4u+D23oXBLwq6j4abSjqk5PZWVR4CwdfFTvzyzdLi
 4Y/XRMUJ9LhstcndVdjS2he3sxTHMINKUl0CLL4PHafer2/q/Ojw1DfLZrTc38rskGYKnb6Oj
 8e1n94yJGpxFmVkjTOENWTX/PmD4ffK6+QCHvNkCUiYNgU/DVsrkjm4CpMwo4YLlb+MFADYDS
 izHd5Vcu1E0CgLVSUzCA==
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

The only users of these got removed, so they also need to be
removed to avoid warnings:

arch/x86/boot/compressed/eboot.c: In function 'setup_efi_pci':
arch/x86/boot/compressed/eboot.c:117:16: error: unused variable 'nr_pci' [-Werror=unused-variable]
  unsigned long nr_pci;
                ^~~~~~
arch/x86/boot/compressed/eboot.c: In function 'setup_uga':
arch/x86/boot/compressed/eboot.c:244:16: error: unused variable 'nr_ugas' [-Werror=unused-variable]
  unsigned long nr_ugas;
                ^~~~~~~

Fixes: 2732ea0d5c0a ("efi/libstub: Use a helper to iterate over a EFI handle array")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/boot/compressed/eboot.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/boot/compressed/eboot.c b/arch/x86/boot/compressed/eboot.c
index da04948d75ed..57dfdc53d714 100644
--- a/arch/x86/boot/compressed/eboot.c
+++ b/arch/x86/boot/compressed/eboot.c
@@ -114,7 +114,6 @@ static void setup_efi_pci(struct boot_params *params)
 	void **pci_handle = NULL;
 	efi_guid_t pci_proto = EFI_PCI_IO_PROTOCOL_GUID;
 	unsigned long size = 0;
-	unsigned long nr_pci;
 	struct setup_data *data;
 	efi_handle_t h;
 	int i;
@@ -241,7 +240,6 @@ setup_uga(struct screen_info *si, efi_guid_t *uga_proto, unsigned long size)
 	u32 width, height;
 	void **uga_handle = NULL;
 	efi_uga_draw_protocol_t *uga = NULL, *first_uga;
-	unsigned long nr_ugas;
 	efi_handle_t handle;
 	int i;
 
-- 
2.20.0

