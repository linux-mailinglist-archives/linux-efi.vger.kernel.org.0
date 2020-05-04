Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA43C1C47BC
	for <lists+linux-efi@lfdr.de>; Mon,  4 May 2020 22:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgEDUNe (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Mon, 4 May 2020 16:13:34 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:43979 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgEDUNe (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Mon, 4 May 2020 16:13:34 -0400
Received: from mail-qk1-f181.google.com ([209.85.222.181]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1MOzKk-1jm7KJ4Bki-00PKU7 for <linux-efi@vger.kernel.org>; Mon, 04 May 2020
 22:13:32 +0200
Received: by mail-qk1-f181.google.com with SMTP id b188so918948qkd.9
        for <linux-efi@vger.kernel.org>; Mon, 04 May 2020 13:13:31 -0700 (PDT)
X-Gm-Message-State: AGi0PubqrDjYPKPgQi0wgwoTPDEwhS2+BpAeFNHF8PpII7OhVoKpdOJC
        uuJzPbA2VddA+JlGSKyEcFWJPDWYyQnJNTecj7Q=
X-Google-Smtp-Source: APiQypLcxG2Z5wV/RT+MFcIDAOG40JnBaTmqsE5nSIyQ6RJuNQ44nvk2/TQkk7qSW2vCd4UdSAVu1owfFCopLp48fsw=
X-Received: by 2002:a37:4e08:: with SMTP id c8mr93935qkb.286.1588623210727;
 Mon, 04 May 2020 13:13:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200504081605.32624-1-ardb@kernel.org> <CAKwvOdkmXm9Md6ErKeF26M-9mtk_f2i23zndOwV_Z6G1yWmY3w@mail.gmail.com>
In-Reply-To: <CAKwvOdkmXm9Md6ErKeF26M-9mtk_f2i23zndOwV_Z6G1yWmY3w@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 4 May 2020 22:13:14 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3q+hntaBU7PEm9HYNPwZeBbWU9w1NjQDNikwNisMhVXQ@mail.gmail.com>
Message-ID: <CAK8P3a3q+hntaBU7PEm9HYNPwZeBbWU9w1NjQDNikwNisMhVXQ@mail.gmail.com>
Subject: Re: [PATCH] efi/libstub/x86: work around LLVM ELF quirk build regression
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        linux-efi <linux-efi@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:AywYnphWx0JX1fHAt1OY0cPMfKQ+bhhjOpEY2lDNq+WVK6eqfhj
 M5DqU2R0pk+IFwUpY6dpT65mFSmbCk1uv8m0KQ9aNyGKyXUjqDYukq+I1rZzpNKMRQ0g1tS
 fY87ZvYHwCHPZhFZmNGsHpGkjX6MYY6p8QRwYh0OCKwfLW5NnkUNFvX0cOM9TNv8mK5UOrU
 Pamz5O9xxAPNlapowmMKw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:9im33gCawv8=:/OP8oyFKlCRSB/lXHGwZyN
 CpZcehK8iETOgFWc9usQGHFUG4mH7YjnkO4durOcEvKVsk4u5fK2FN51WF14t3cexzP9Fe+Ot
 D9m/VYMhk816r7/IMXvmDr2/tWL1XpjYE9hoPhNEWB/6iEeBNybu8k2aTUsz44wBzZTCRdtEy
 1+BShM7hDzvD3Gu+IDqelV2WSClyFM3i4DXvCm/Mez6vbIlExqnFaLPOKsRtcs4zbJN070fJ4
 k2jxcF8NVVjhhFuNDNvb8lY94+gRdB/OqvlG1UWWD0bm5ZCbw3Ey+Jg/72HfuRsftu3QA2+3d
 eEjdES4FtwWGuX4T4ZLAn0zT683CvyTwThw31Ey4WdDrZdrqtKnV92lo/aIe6SCXWCvPBv0i9
 BPAFiZovd2o3ey2AQtMdBPzbT+mFOrp4tzZHdLDlyFj/E1p1i7Ac7avVIhrTYKF2L1YcYz2AP
 v5Ig/QH8/mdgKtHpiRG+fJ7baKqp+z8J4zEaHrWHRhkJdEF6+uPiKhA7d6tTPcKQ8/Kz43O2w
 DK2gJK9JAlu3jlq+hIsBijHlTWFc7sSzyVubdCPK++Gk7pxFWjQwxBr7bPtNw9x9gd8Guse0B
 KL/w01/FQj7wsgWBd+15oUY252cd8ScVZUCvXIOtE5EDsQX53GpLwl4XR3F9kIioGVr6XPfyF
 XorQ4yqXRRvPzNRLKoF9E9Nx++wEl5G7rPyuFqV3s0HSCtNAecKuFyT/anu58Mt4+fNMx4zsM
 o6OUIsLaYCCq721IzmNFd4Gahv3YGp6KtaK+O6YdNogacnYOi0srz1SOcGpJMohmZ1ypINvGO
 rZ39owNcIhegk9HljYP0QDkbO5Peeh7B7M+TekuaRbwzTBjw/s=
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Mon, May 4, 2020 at 8:54 PM 'Nick Desaulniers' via Clang Built
Linux <clang-built-linux@googlegroups.com> wrote:
>
> On Mon, May 4, 2020 at 1:16 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > Cc: Nick Desaulniers <ndesaulniers@google.com>
> > Reported-by: Arnd Bergmann <arnd@arndb.de>
>
> Do you have a link to the configs or report so we can repro?

I ran into this four times over a day, here are two such configs:

https://pastebin.com/raw/cjNdRfF4
https://pastebin.com/raw/pYKUrW56

     Arnd
