Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D99D9179862
	for <lists+linux-efi@lfdr.de>; Wed,  4 Mar 2020 19:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbgCDSup (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Wed, 4 Mar 2020 13:50:45 -0500
Received: from mail-qv1-f68.google.com ([209.85.219.68]:34629 "EHLO
        mail-qv1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729600AbgCDSup (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Wed, 4 Mar 2020 13:50:45 -0500
Received: by mail-qv1-f68.google.com with SMTP id o18so1273697qvf.1;
        Wed, 04 Mar 2020 10:50:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tuKeD8w66KIDzJ6/Silhroq3Yhej0TOjlxLZqNMh/QM=;
        b=K1STWgSZRij5Bsdjl9V2EgJs+J4iSVnfdNGfBDMF3VM4W1yBesmPlhQBeCIAEPoAIG
         UKdX5a5JpcF1I0AwopypkUDjo2YD1SdgU3aj+54kL1E0T0y+jwAf+RIprktg2kdRlYet
         +VZkbdPAHsJzlYHJ7dZX7TgJ+pJKfSgjH4ejwDfBOEHMQMK4PBSBDZBV2RqTwu+v5yRk
         l1QxwcdJAT2wGgHSsgzhrLrgA7K9vtpGGKe+oRm+smgX5PjaItVnANiJD/MAssgGZOen
         syKJx9ycWoI6Io4rfbz74u0LITlLoAVSNdtnP6c4Unxj5fWFH/Wn0fb0m2KCLlvR3Oj4
         EErQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=tuKeD8w66KIDzJ6/Silhroq3Yhej0TOjlxLZqNMh/QM=;
        b=HCf0+ww7O8wtnA/6cLGQ0Kkko6SzIqsKD5sRUIU5AVgZgLssaUvPusi3C3LdSi/peg
         6ydHbgkILldtcz3JtzU/F7agXPctBH2uJyGN4792YwgehXGJHoQsgMGNzFVqaxZ8LFim
         BiukQonzZ88z27w3hSQXFs4sA4qhNNpa36gJZB3FvuFyqtSEKqXBDcx6l7mF7ti6jgJ3
         U8Ttd2OradKMVXL5GbLQtC3WXNrkNcpOnrj86JCF+k9dWYYuRf9U3Y9Sq2xFtPDMDD4m
         C3xb6V0ufMPkutyhZhy3yWvC4vofZMsvusZl7oVVaAuXeq3J6323RXm50/iZUOvVN276
         U24A==
X-Gm-Message-State: ANhLgQ1xbZ+q+wZTH+3DFemKylKihue/o36W/OrTsd6LGaAHi/Ame+Rq
        Q5m5mR3kvj4LEhjY9t6MFs8=
X-Google-Smtp-Source: ADFU+vvcHTTpUmq/oVhZPERdJnhVc0CitiLhAmu8LJV5u9LJLmOoWzbIy7cua1LZX3gHfG90YayF/Q==
X-Received: by 2002:a05:6214:1933:: with SMTP id es19mr3223597qvb.14.1583347844236;
        Wed, 04 Mar 2020 10:50:44 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id 202sm14061573qkg.132.2020.03.04.10.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 10:50:44 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Wed, 4 Mar 2020 13:50:42 -0500
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
Message-ID: <20200304185042.GA281042@rani.riverdale.lan>
References: <20200303205445.3965393-1-nivedita@alum.mit.edu>
 <20200303205445.3965393-2-nivedita@alum.mit.edu>
 <CAKv+Gu_LmntqGjkakR0-SFSCR+JF+CFeKyc=5qzOdpn4wTvKhw@mail.gmail.com>
 <20200304154908.GB998825@rani.riverdale.lan>
 <CAKv+Gu-Xo2zj9_N+K8FrpBstgU57GZvWO-pDr4tRAODhsYzW-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu-Xo2zj9_N+K8FrpBstgU57GZvWO-pDr4tRAODhsYzW-A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Wed, Mar 04, 2020 at 07:44:50PM +0100, Ard Biesheuvel wrote:
> 
> I've tried a couple of different ways, but I can't seem to get my
> memory map organized in the way that will trigger the error.

What does yours look like? efi_merge_regions doesn't merge everything
that will eventually be mapped the same way, so if there are some
non-conventional memory regions scattered over the address space, it
might be breaking up the mappings to the point where this doesn't
trigger.
