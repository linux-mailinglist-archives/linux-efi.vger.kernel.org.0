Return-Path: <linux-efi+bounces-4472-lists+linux-efi=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 504F9B10B25
	for <lists+linux-efi@lfdr.de>; Thu, 24 Jul 2025 15:15:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2454E16B42E
	for <lists+linux-efi@lfdr.de>; Thu, 24 Jul 2025 13:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85EA52D5C9E;
	Thu, 24 Jul 2025 13:15:05 +0000 (UTC)
X-Original-To: linux-efi@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.120])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B023F2D6405;
	Thu, 24 Jul 2025 13:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.42.244.120
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753362905; cv=none; b=m+YonTJQF6SKGC2g2mPgI99apzgt7GFTiJvPhKwCmReqcTtl0z3384umuhtup3aa8w/2qgT9ZYEjd9D/+3MIyDaGQpEGe9O+2Nb0bUUIxSwy40z7EjkcGtc44yA0m8/5s1gjKOoOoAxSTDVIiAgS04vcJk1nrZ7ReJMf2uZ8tOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753362905; c=relaxed/simple;
	bh=ne/XcgrgO/KJ5Vpn5Kmd1KTfFMh8OZxebN5iFuDYEM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RP9xDJCNfzdKSa+xNXYbL10zkz9slWLyA2dey0l9rXBb/aqlE6ZEYH5om7t7Nv/7iGGu8qEt/ByUAPKDTsNABCACWOgtuiSuiDHAl/8k6r4BrYS34zejdW1xkUpWBdsHM+dmDP2NtGku1lMTe7XMUL/ldH56HDj2YpS9c3wquCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=avm.de; arc=none smtp.client-ip=212.42.244.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=avm.de
Received: from [212.42.244.71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.53.4)
	(envelope-from <n.schier@avm.de>)
	id 6882306d-0380-7f0000032729-7f000001eb7c-1
	for <multiple-recipients>; Thu, 24 Jul 2025 15:09:01 +0200
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [212.42.244.71])
	by mail.avm.de (Postfix) with ESMTPS;
	Thu, 24 Jul 2025 15:09:01 +0200 (CEST)
Received: from buildd.core.avm.de (buildd-sv-01.avm.de [172.16.0.225])
	by mail-auth.avm.de (Postfix) with ESMTPA id 09A4980AA3;
	Thu, 24 Jul 2025 15:09:02 +0200 (CEST)
Received: from l-nschier-aarch64.ads.avm.de (unknown [IPv6:fde4:4c1b:acd5:6472::1])
	by buildd.core.avm.de (Postfix) with ESMTPS id 6DAEF184464;
	Thu, 24 Jul 2025 15:09:00 +0200 (CEST)
Date: Thu, 24 Jul 2025 15:08:58 +0200
From: Nicolas Schier <nicolas.schier@linux.dev>
To: Kees Cook <kees@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Marco Elver <elver@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kbuild@vger.kernel.org, kasan-dev@googlegroups.com,
	linux-hardening@vger.kernel.org, Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Gavin Shan <gshan@redhat.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	James Morse <james.morse@arm.com>,
	Oza Pawandeep <quic_poza@quicinc.com>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Mike Rapoport <rppt@kernel.org>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
	Michal Wilczynski <michal.wilczynski@intel.com>,
	Juergen Gross <jgross@suse.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	"Kirill A. Shutemov" <kas@kernel.org>,
	Roger Pau Monne <roger.pau@citrix.com>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Usama Arif <usama.arif@bytedance.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	Thomas Huth <thuth@redhat.com>, Brian Gerst <brgerst@gmail.com>,
	Hou Wenlong <houwenlong.hwl@antgroup.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Andy Lutomirski <luto@kernel.org>, Baoquan He <bhe@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Changyuan Lyu <changyuanl@google.com>,
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serge@hallyn.com>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jan Beulich <jbeulich@suse.com>, Boqun Feng <boqun.feng@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Bibo Mao <maobibo@loongson.cn>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, x86@kernel.org,
	kvm@vger.kernel.org, ibm-acpi-devel@lists.sourceforge.net,
	platform-driver-x86@vger.kernel.org, linux-acpi@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
	linux-mm@kvack.org, kexec@lists.infradead.org,
	linux-security-module@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v4 4/4] kstack_erase: Support Clang stack depth tracking
Message-ID: <20250724-optimistic-armadillo-of-joviality-e59222@l-nschier-aarch64>
References: <20250724054419.it.405-kees@kernel.org>
 <20250724055029.3623499-4-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-efi@vger.kernel.org
List-Id: <linux-efi.vger.kernel.org>
List-Subscribe: <mailto:linux-efi+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-efi+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20250724055029.3623499-4-kees@kernel.org>
Organization: AVM GmbH
X-purgate-ID: 149429::1753362541-3C575E1C-2FB622E2/0/0
X-purgate-type: clean
X-purgate-size: 870
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean

On Wed, Jul 23, 2025 at 10:50:28PM -0700, Kees Cook wrote:
> Wire up CONFIG_KSTACK_ERASE to Clang 21's new stack depth tracking
> callback[1] option.
>=20
> Link: https://clang.llvm.org/docs/SanitizerCoverage.html#tracing-stack-de=
pth [1]
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Masahiro Yamada <masahiroy@kernel.org>
> Cc: Nathan Chancellor <nathan@kernel.org>
> Cc: Nicolas Schier <nicolas.schier@linux.dev>
> Cc: Marco Elver <elver@google.com>
> Cc: Andrey Konovalov <andreyknvl@gmail.com>
> Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
> Cc: <linux-kbuild@vger.kernel.org>
> Cc: <kasan-dev@googlegroups.com>
> Cc: <linux-hardening@vger.kernel.org>
> ---

Acked-by: Nicolas Schier <n.schier@avm.de>

