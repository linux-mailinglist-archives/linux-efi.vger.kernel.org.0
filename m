Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0ADBF196C5B
	for <lists+linux-efi@lfdr.de>; Sun, 29 Mar 2020 12:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbgC2KIx (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Sun, 29 Mar 2020 06:08:53 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:35306 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgC2KIx (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Sun, 29 Mar 2020 06:08:53 -0400
Received: by mail-wr1-f48.google.com with SMTP id d5so17379843wrn.2
        for <linux-efi@vger.kernel.org>; Sun, 29 Mar 2020 03:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=I9LZfTAUvj4l0VFm3AzcLI9QplZWD2P9UnW3NXnGF9M=;
        b=IRmzCr7QdBPOyGuZ5M1RkAwJpRbbix79U7fIQ6ghXzQ7pguJ/22GcCaC344QywSAOo
         hrHpccMZXSsfsQsQENVBc6hNyq8f9rpaKDh2WKMLKwNyYjGjx+Jz9tWGvg93kMyCYvXj
         eCA6sgxw95beYHYE2+B259K7y5jGeumGkvto/RHp9tUQ2k24zPtewI6nUR/OWfq0/z2X
         pyaIjv+9cooPvqucta+HJC7jCMH6V8tINdE+dQNlgbJD4exMQOx0IlJzGtpdnzNy7mlz
         WX18RLh7eOIi0P9Zk5wFJNlOU52lLbcGmXBfGw6lVeYm6M0o+4vI0aGp027y9NwAtL5W
         Vnxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=I9LZfTAUvj4l0VFm3AzcLI9QplZWD2P9UnW3NXnGF9M=;
        b=qyKXv65CAZTE3HM64ILlxthgcrhfRI8VIaBqXBhuEqEXDKNjnGVMrVSefZZtCF8ty9
         DgSLEC+oHRkzIshDALQ1MdDxd5DtWxZ7sYYnza9eIY1wQclo6clyiT4MbfEwnGDz/oGg
         9VqJmEdjhcaqVEsW/CVlU/RQIZga3glcfEIXUJAzZ8Hd34atA7LepuCSb3riaqUIZbMj
         HnWltmWLgen0+YhHhBPNkbrdOJ1g1vNeOJD5fxpk82+y3HabYzjilD/jsWAh4KnYyQ5y
         Vr6ida1U+ABThZZtWTMA8PzN50jy8gnlckLW9MgxfNyLiKB0lvw94YDFwDU0Za+Ew2JY
         arFQ==
X-Gm-Message-State: ANhLgQ10npFSIYmZXsTz6U9vMsA/+268ZWzFlKwa9Q3CFIifnoKJB/E4
        wCj1Ms5b8KAA8PMA548Sk9U=
X-Google-Smtp-Source: ADFU+vtLoYmfS50rmRhDXGJyAsseWR8u6C6stoPJ0RB3K2Qwq2KscVn83d0QVWvlOEyONyM+l7KebQ==
X-Received: by 2002:adf:8182:: with SMTP id 2mr8689172wra.37.1585476531346;
        Sun, 29 Mar 2020 03:08:51 -0700 (PDT)
Received: from gmail.com (54033286.catv.pool.telekom.hu. [84.3.50.134])
        by smtp.gmail.com with ESMTPSA id k3sm17517162wrw.61.2020.03.29.03.08.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2020 03:08:50 -0700 (PDT)
Date:   Sun, 29 Mar 2020 12:08:49 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     linux-efi@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        Borislav Petkov <bp@alien8.de>
Subject: Re: [GIT PULL 0/2] EFI touchups for v5.7
Message-ID: <20200329100848.GC93574@gmail.com>
References: <20200329080544.25715-1-ardb@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200329080544.25715-1-ardb@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org


* Ard Biesheuvel <ardb@kernel.org> wrote:

> Hello Ingo, Thomas,
> 
> Please pull the below into tip:efi/core - it is a pair of fixes for the
> code that has been queued up for v5.7
> 
> Thanks,
> Ard.

Applied to tip:efi/core, thanks Ard!

	Ingo
