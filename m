Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8453F179BDC
	for <lists+linux-efi@lfdr.de>; Wed,  4 Mar 2020 23:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388412AbgCDWkG (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Mar 2020 17:40:06 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39393 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388281AbgCDWkF (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Mar 2020 17:40:05 -0500
Received: by mail-qt1-f194.google.com with SMTP id e13so2711762qts.6;
        Wed, 04 Mar 2020 14:40:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=feOnCN+Y0rQBJPN3bP11NNN5wOI8xf9VdxZEkk0/kGQ=;
        b=lNJIoHOg4x/rDJ3ZgZ2VbInIRw7Edj0fkDgxTw2YNEeZlxxU8WxHLQEfLBXgG+lPEK
         YEeG/ZACpcdTdOiFVGUWUwu/XzLstSxATXc1SFzzQM00XY39ZuPfCI1rXv8QAU7UogH7
         r9emQtUrxLti7PUtYuolWemZ+56O2jxVLUNrc2d42okoFuwUMvP8uv890loIB7cAp0Tb
         /lmQ8q1LnLIsRSv4QNpCvsMkMa18x2yHj1l3/tp4sJrLU81tFOPG2eHTJXTwONr9JYQY
         Hp3h/Xxxt9vifr376EtbADQm4F63/t3gTfTha3mxIPSXAGxGJSLJ5oUkVnDEVHNcOaiZ
         shAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=feOnCN+Y0rQBJPN3bP11NNN5wOI8xf9VdxZEkk0/kGQ=;
        b=LisONSZ2RLW0EqSeuQxdE6Nlwhe3ggi+SVGlVa+ZH44oM1VVKw8Qt/dXJmkEaIsF5Q
         CNWFhAYCIY2H+3Kqk8T+iykChBSj46+wUFWp99jcSS5nioXrTOUqBxiUHP12DM3fdAZy
         b0z9BRo2XxphiORF3k0vv80aCo5SJJsZs6MIDP1iON0V3c3umRZr/rjktyAsjE4G/gt0
         Q0uBmUgSZjMeXwwFB6e6IwpxhlGCd7TDmWFYTOVoaQEh3i/pOD2eDx6RP6MflHeAcCOo
         qx5dS3ypfR9dTxzfHEDFZfHIW/T3LeXO3TGPSZ6TtowYuM2rnfe0CwtFffyWSv6/lr9N
         W0tg==
X-Gm-Message-State: ANhLgQ3cRjdDqnBMugkMrVfu8OEYhwleiuSr4gcrJGr2NTXINxGwgg+5
        TPSzm2ts75joFvfGuhi8aGw=
X-Google-Smtp-Source: ADFU+vsQJSdGKIEy7u65Y3clG6XrDsdnH/unXYT6C7zgOVlFSPKuiU/V5WQcdHXMfFA8AjRKQXp/4A==
X-Received: by 2002:ac8:4547:: with SMTP id z7mr4635518qtn.33.1583361604658;
        Wed, 04 Mar 2020 14:40:04 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id x34sm10786493qta.82.2020.03.04.14.40.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 14:40:04 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 4 Mar 2020 17:40:02 -0500
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
Message-ID: <20200304224002.GA511869@rani.riverdale.lan>
References: <20200303205445.3965393-2-nivedita@alum.mit.edu>
 <CAKv+Gu_LmntqGjkakR0-SFSCR+JF+CFeKyc=5qzOdpn4wTvKhw@mail.gmail.com>
 <20200304154908.GB998825@rani.riverdale.lan>
 <CAKv+Gu-Xo2zj9_N+K8FrpBstgU57GZvWO-pDr4tRAODhsYzW-A@mail.gmail.com>
 <20200304185042.GA281042@rani.riverdale.lan>
 <CAKv+Gu-6YoJMLbR8UUsBeRPzk7r_4aKBprqay2kf6cKMPwsHgQ@mail.gmail.com>
 <20200304191053.GA291311@rani.riverdale.lan>
 <CAKv+Gu84Bj4tBz=+FhG6cqpYUjc5czaqiNAVDdKgqGoXbnHKbQ@mail.gmail.com>
 <20200304195447.GA295419@rani.riverdale.lan>
 <CAKv+Gu8sTuj+Wkk8g2tv+1k9LczXV4yV4KSbaJ6Bs69SQwR2_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu8sTuj+Wkk8g2tv+1k9LczXV4yV4KSbaJ6Bs69SQwR2_A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Mar 04, 2020 at 10:51:01PM +0100, Ard Biesheuvel wrote:
> On Wed, 4 Mar 2020 at 20:54, Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > You're *sure* the after is actually after? There seems to be no change
> > at all, the patch should have had some effect.
> 
> Duh.
> 
> Yes, you are right. It was 'operator error'

Phew! Thanks for the test :)
