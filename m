Return-Path: <linux-efi+bounces-4466-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF58B10015
	for <lists+linux-efi@lfdr.de>; Thu, 24 Jul 2025 07:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5672D1C22639
	for <lists+linux-efi@lfdr.de>; Thu, 24 Jul 2025 05:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7396202C48;
	Thu, 24 Jul 2025 05:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0/TMlHJ"
X-Original-To: linux-efi@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC5119A;
	Thu, 24 Jul 2025 05:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753336230; cv=none; b=IpAVAd2sdeb+i90SpfFcJ13FSAaJ2K8PdcNMwrGWjxgoBqH/vBssrXKevYhkk7dH2CoxnBblcUC2ffuY3FReU0FWneoeV0drh0JLtnoSSTCVjknQvqlq/5LqFKtIgW9f55eFqVqJZILq7RzSdyBrFq2xdmrXkDaIpY9C1o0XR54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753336230; c=relaxed/simple;
	bh=XE3wpC5OKAVRvxdPiqi/2WsaLPvDes1ay28krOB8Nyg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=GbvBthKYc2PBKFKeWlHtxGVmfWQkQAumr14Qv7e8tvzlf+Z0CGh7o9BwA1Cg+UFsWT5Z35YS4WNxzuTi6V3A0oallX0Mb4lC4chVV643wW+iIjjFT2JR51lkt2Y0GLrKAC918ZXZDOtYEjpNRT6+Pfmtxngk892fQxEtTyNuouY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d0/TMlHJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA19C4CEF4;
	Thu, 24 Jul 2025 05:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753336230;
	bh=XE3wpC5OKAVRvxdPiqi/2WsaLPvDes1ay28krOB8Nyg=;
	h=From:To:Cc:Subject:Date:From;
	b=d0/TMlHJD3g/KJWGAgQ/f/vsSu6dz+U/wQhw7RJ+hpjI1X/Sb0vKcWNoCHtrHbwiT
	 fH44GGf8Ya+PkaTReniUuYLdOVN2Z7VZtAILtvfvcjiAgUuEzQ5NtxiABxovHh0dhh
	 CjjXTbcKODbX01+IxIuANaBudNKSlp4sTNUtj/Dm700M2Xeul+T3LNAq2Cwpvn93hM
	 3mtHpKM4dxgJplW4BiyL41PLzD8gk1AUnlrUjfa7EyvQF15EPpx30bWI4LoLGEpTl8
	 AnYSr9DuaqtX57N9wGYm/6ZnjhE8O4TTw5SsPmlN/kayzZrdvOKdlCPjUMa8a9ErZI
	 bpYkRhkl38Olg==
From: Kees Cook <kees@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kees Cook <kees@kernel.org>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Gavin Shan <gshan@redhat.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	James Morse <james.morse@arm.com>,
	Oza Pawandeep <quic_poza@quicinc.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Mike Rapoport <rppt@kernel.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Michal Wilczynski <michal.wilczynski@intel.com>,
	Juergen Gross <jgross@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Kirill A. Shutemov" <kas@kernel.org>,
	Roger Pau Monne <roger.pau@citrix.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Usama Arif <usama.arif@bytedance.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Thomas Huth <thuth@redhat.com>,
	Brian Gerst <brgerst@gmail.com>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Hou Wenlong <houwenlong.hwl@antgroup.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Andy Lutomirski <luto@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Changyuan Lyu <changyuanl@google.com>,
	Paul Moore <paul@paul-moore.com>,
	James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jan Beulich <jbeulich@suse.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Bibo Mao <maobibo@loongson.cn>,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	x86@kernel.org,
	kvm@vger.kernel.org,
	ibm-acpi-devel@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-mm@kvack.org,
	kasan-dev@googlegroups.com,
	linux-kbuild@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	kexec@lists.infradead.org,
	linux-security-module@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v4 0/4] stackleak: Support Clang stack depth tracking
Date: Wed, 23 Jul 2025 22:50:24 -0700
Message-Id: <20250724054419.it.405-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1439; i=kees@kernel.org; h=from:subject:message-id; bh=XE3wpC5OKAVRvxdPiqi/2WsaLPvDes1ay28krOB8Nyg=; b=owGbwMvMwCVmps19z/KJym7G02pJDBmNJxc5mZrpNj5K4tORy/7TeZXhw9upF18pr/M4P+mO0 qJ1Zxv/dZSyMIhxMciKKbIE2bnHuXi8bQ93n6sIM4eVCWQIAxenAExkx3ZGhj3Lo9RPfd61sO3K 6ZOX39cZ7GLmn/6vehbf2xvW83qXM01nZOhJWph/qli05kP325oNd1z3S2krH/3OsOnxZQ05w52 HynkB
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

 v4:
  - rebase on for-next/hardening tree (took subset of v3 patches)
  - improve commit logs for x86 and arm64 changes (Mike, Will, Ard)
 v3: https://lore.kernel.org/lkml/20250717231756.make.423-kees@kernel.org/
 v2: https://lore.kernel.org/lkml/20250523043251.it.550-kees@kernel.org/
 v1: https://lore.kernel.org/lkml/20250507180852.work.231-kees@kernel.org/

Hi,

These are the remaining changes needed to support Clang stack depth
tracking for kstack_erase (nee stackleak).

Thanks!

-Kees

Kees Cook (4):
  arm64: Handle KCOV __init vs inline mismatches
  x86: Handle KCOV __init vs inline mismatches
  init.h: Disable sanitizer coverage for __init and __head
  kstack_erase: Support Clang stack depth tracking

 security/Kconfig.hardening      | 5 ++++-
 scripts/Makefile.kstack_erase   | 6 ++++++
 arch/arm64/include/asm/acpi.h   | 2 +-
 arch/x86/include/asm/acpi.h     | 4 ++--
 arch/x86/include/asm/init.h     | 2 +-
 arch/x86/include/asm/realmode.h | 2 +-
 include/linux/acpi.h            | 4 ++--
 include/linux/bootconfig.h      | 2 +-
 include/linux/efi.h             | 2 +-
 include/linux/init.h            | 4 +++-
 include/linux/memblock.h        | 2 +-
 include/linux/smp.h             | 2 +-
 arch/x86/kernel/kvm.c           | 2 +-
 arch/x86/mm/init_64.c           | 2 +-
 kernel/kexec_handover.c         | 4 ++--
 15 files changed, 28 insertions(+), 17 deletions(-)

-- 
2.34.1


