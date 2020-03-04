Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E2CDA17995B
	for <lists+linux-efi@lfdr.de>; Wed,  4 Mar 2020 20:54:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729008AbgCDTyv (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Mar 2020 14:54:51 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36924 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728955AbgCDTyu (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Mar 2020 14:54:50 -0500
Received: by mail-qt1-f195.google.com with SMTP id j34so2353263qtk.4;
        Wed, 04 Mar 2020 11:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Der7PfXctUbuhZwpZLRkccXATBZ5Hd74PYiD6oH1JBo=;
        b=J31KVlv2/mnOly6BumvfB1PwUnPby40m1/mH3vfkoye8+kHF1mkn5M4kr0DS/ubJMg
         Psc6JFuy0Q0Gapmi4OQdJ35AIsccbBXEOeuTELpB8s+qof3PdpXcDPpum9QJBoeVxLhg
         NIl97gLln6JG7Uh9XMQIF00U9wcxSP1NOiMHqW/vHpD9HjKljiNAyJ+SAUtYg+oWWbJS
         Zw0sH36vR6Qs/wBJ+13sOJkxBLKcBSuYvpt4o1z63/iBL7Vz+cVL/awPakwslhID/fWf
         zF1sFWsMMtX/ul3iU68H8ZVxdTtzpRI5IsEKKoV2hTSTUbl5nzAL2+1P/o+dC9fW+3xf
         syDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Der7PfXctUbuhZwpZLRkccXATBZ5Hd74PYiD6oH1JBo=;
        b=PDQoBZZoJmVQ8CToSnG1w11wha/R7XvDQQNR6f6eJUY3DzSSi1D1Hu6mXbY/H30RKE
         79mA+QXeFWp3G69JwuRymIsCAiO2Cm4bTquDukpECDAH2BigmHkh9h8q10Vry2O71GJl
         aSpdYO9tyqUe9Gr6IQJVn+y39nG0mkvD/SbWu25J7OqjMwl1t/pEitynOsgUD1bl7mj9
         1PeanOZ1Wi7P8NffifjiZJ52QvuFzcRJ3caxlJRuN/R50OXFS3zMx4wudqJcn+ojmbWq
         Iyi6+DWGoI/AKiq/zBgZMvcERxJPRP/uiCem7je87bNIoAlprAG3+p0K6vNiE2TL9qxN
         TyHw==
X-Gm-Message-State: ANhLgQ0lcW5PoPZ0VKYgIMtkxccYvG9BmMyu9Ig7SpPjbhRTCkCBECYO
        g8Pcdp6DmiBkDQtv4xcklWI=
X-Google-Smtp-Source: ADFU+vt+akuAH9EN9p59v/Q9PrJ6lezqIaIblI7A5GBRc4FUgkz03ni33mXvHBFwGsUfH+3eWXZ1bg==
X-Received: by 2002:ac8:c4f:: with SMTP id l15mr3990412qti.177.1583351689795;
        Wed, 04 Mar 2020 11:54:49 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id p18sm14352924qkp.47.2020.03.04.11.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 11:54:49 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 4 Mar 2020 14:54:47 -0500
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] x86/mm/pat: Handle no-GBPAGES case correctly in
 populate_pud
Message-ID: <20200304195447.GA295419@rani.riverdale.lan>
References: <20200303205445.3965393-1-nivedita@alum.mit.edu>
 <20200303205445.3965393-2-nivedita@alum.mit.edu>
 <CAKv+Gu_LmntqGjkakR0-SFSCR+JF+CFeKyc=5qzOdpn4wTvKhw@mail.gmail.com>
 <20200304154908.GB998825@rani.riverdale.lan>
 <CAKv+Gu-Xo2zj9_N+K8FrpBstgU57GZvWO-pDr4tRAODhsYzW-A@mail.gmail.com>
 <20200304185042.GA281042@rani.riverdale.lan>
 <CAKv+Gu-6YoJMLbR8UUsBeRPzk7r_4aKBprqay2kf6cKMPwsHgQ@mail.gmail.com>
 <20200304191053.GA291311@rani.riverdale.lan>
 <CAKv+Gu84Bj4tBz=+FhG6cqpYUjc5czaqiNAVDdKgqGoXbnHKbQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu84Bj4tBz=+FhG6cqpYUjc5czaqiNAVDdKgqGoXbnHKbQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Mar 04, 2020 at 08:22:36PM +0100, Ard Biesheuvel wrote:
> The wrong one, obviously :-)
> 
> With Haswell, I get [before]
> 
> [    0.368541] 0x0000000000900000-0x0000000000a00000           1M
> RW                     NX pte
> [    0.369118] 0x0000000000a00000-0x0000000080000000        2038M
> RW         PSE         NX pmd
> [    0.369592] 0x0000000080000000-0x00000000b9800000         920M
>                          pmd
> [    0.370177] 0x00000000b9800000-0x00000000b9856000         344K
>                          pte
^^ so this is showing the region that didn't get mapped, so you did
reproduce the issue.
> [    0.370649] 0x00000000b9856000-0x00000000b9a00000        1704K
> RW                     NX pte
> [    0.371066] 0x00000000b9a00000-0x00000000baa00000          16M
> ro         PSE         x  pmd
> 
> and after
> 
> [    0.349577] 0x0000000000a00000-0x0000000080000000        2038M
> RW         PSE         NX pmd
> [    0.350049] 0x0000000080000000-0x00000000b9800000         920M
>                          pmd
> [    0.350514] 0x00000000b9800000-0x00000000b9856000         344K
>                          pte
^^ but it didn't get fixed :( This region should now be mapped properly
with flags RW/NX.
> [    0.351013] 0x00000000b9856000-0x00000000b9a00000        1704K
> RW                     NX pte
> 
> so i'm still doing something wrong, I think?

You're *sure* the after is actually after? There seems to be no change
at all, the patch should have had some effect.
