Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6F469102C8B
	for <lists+linux-efi@lfdr.de>; Tue, 19 Nov 2019 20:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfKST1k (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 19 Nov 2019 14:27:40 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42980 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfKST1k (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Tue, 19 Nov 2019 14:27:40 -0500
Received: by mail-qt1-f194.google.com with SMTP id t20so25930113qtn.9
        for <linux-efi@vger.kernel.org>; Tue, 19 Nov 2019 11:27:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wWke+FPRS6Ykc0nO40qrsc1dQ72uzYDMM9s/rffQgXo=;
        b=cOwJdQ3QaoC1ghWuL5cDionr9lVRVE7w0E6xB29suEcWQZJDbarxSfoUMmuspYbOvs
         foTc3R4N1YA6vsxpIjJbpSttqpBQ3dDDQi4PwvY4v0Tei1oeHkTXBrFblLAZtKjFSVZT
         k6iJPky6g4ughqLuVvoeuzEMq/7B1gpdHqjeEKLzSldt+RKr3YKXU3JvPlzO5+msV6uZ
         6v3vYAlWY89i/LBzOxKeer2saajdLI87BirnkGA6ad3ouHDNIw5STroNQNgNVW12VIMO
         YBsvns+jHm88LTfB94IIPjtkpMzbROhq16RxFtaOcBoM1QlTB/1om5GndImlFebJg1IB
         mGiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wWke+FPRS6Ykc0nO40qrsc1dQ72uzYDMM9s/rffQgXo=;
        b=jxZxm8cZ8WhND6AH1JxcJ/gehRT2+KMfa43HIeKUzIbedywfpHCMieb4fpQwTDiY3M
         56GmdZu/cHv+6uda86dNjBrcwIuv8ep+YfeNTO9azYFiUtz7sPvQ29sgrQVPo8Uvg9Pv
         pq+HmTcKdZRSWjEjJFh2Zm3hcbOXuH12hpL6GVOHMi1eHA3SGXqePfQ7AkPjDBGhqn9t
         vy/Wz86oVVuwej5pQ8YozywnEuVw0BQqfKw75obWLA0jc2bOS7xCaFF1sEHGdLS+wrYq
         jjZjqkn/k2DhPr4TT00zoxppifgVEOyE3MZirLIslF8zBTi4lwjW8K01TuueGw8mnq1z
         NQag==
X-Gm-Message-State: APjAAAU2/QMZ9hT3QcSqrT5tPghDtJyObLwe0nyu7eYx8NncIGtiGYYH
        qVLPVIYdrW5JMo1fCiRSGh14yQ==
X-Google-Smtp-Source: APXvYqwqqbIYdbA/gvquqIqz/2jzv9H8hpK3t4AE1C7xJadrM0qWrSPiW0jc/PVgaAG39wcWgRtWhw==
X-Received: by 2002:ac8:244e:: with SMTP id d14mr35262717qtd.388.1574191657402;
        Tue, 19 Nov 2019 11:27:37 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 134sm10319529qkn.24.2019.11.19.11.27.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Nov 2019 11:27:36 -0800 (PST)
Message-ID: <1574191653.9585.6.camel@lca.pw>
Subject: Re: [PATCH v4 01/10] kcsan: Add Kernel Concurrency Sanitizer
 infrastructure
From:   Qian Cai <cai@lca.pw>
To:     Marco Elver <elver@google.com>
Cc:     akiyks@gmail.com, stern@rowland.harvard.edu, glider@google.com,
        parri.andrea@gmail.com, andreyknvl@google.com, luto@kernel.org,
        ard.biesheuvel@linaro.org, arnd@arndb.de, boqun.feng@gmail.com,
        bp@alien8.de, dja@axtens.net, dlustig@nvidia.com,
        dave.hansen@linux.intel.com, dhowells@redhat.com,
        dvyukov@google.com, hpa@zytor.com, mingo@redhat.com,
        j.alglave@ucl.ac.uk, joel@joelfernandes.org, corbet@lwn.net,
        jpoimboe@redhat.com, luc.maranget@inria.fr, mark.rutland@arm.com,
        npiggin@gmail.com, paulmck@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, will@kernel.org, edumazet@google.com,
        kasan-dev@googlegroups.com, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-efi@vger.kernel.org,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, x86@kernel.org
Date:   Tue, 19 Nov 2019 14:27:33 -0500
In-Reply-To: <20191114180303.66955-2-elver@google.com>
References: <20191114180303.66955-1-elver@google.com>
         <20191114180303.66955-2-elver@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Thu, 2019-11-14 at 19:02 +0100, 'Marco Elver' via kasan-dev wrote:

> +menuconfig KCSAN
> +	bool "KCSAN: watchpoint-based dynamic data race detector"
> +	depends on HAVE_ARCH_KCSAN && !KASAN && STACKTRACE

"!KASAN" makes me sorrow. What's problem of those two?

> +	default n
> +	help
> +	  Kernel Concurrency Sanitizer is a dynamic data race detector, which
> +	  uses a watchpoint-based sampling approach to detect races. See
> +	  <file:Documentation/dev-tools/kcsan.rst> for more details.
> +

