Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D978015CF25
	for <lists+linux-efi@lfdr.de>; Fri, 14 Feb 2020 01:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727665AbgBNAih (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 13 Feb 2020 19:38:37 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40028 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727604AbgBNAig (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 13 Feb 2020 19:38:36 -0500
Received: by mail-qk1-f196.google.com with SMTP id b7so7618380qkl.7
        for <linux-efi@vger.kernel.org>; Thu, 13 Feb 2020 16:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wGH4VY/3ugpp7nzWpAp09Rovcx+O4RdGGz99VfpVE0k=;
        b=V6RIg5lFKn8SGTXOEVEEQWPnDFJIa4x7oTbMlHJPCCvjD1SQumScY4+/x01VueDwjQ
         oX1sqPAK7GOJLWeGDhHeh+x4SzW2+6F002PxORIApjUQlam4ShwKYf7hn8v3+BCTkbnB
         Vv+5WZp2o3wgLsnoZomZ1m/28AlD/pQDDszTehbmWVOMF9Y1EZGBOoxVYpSeNVJfzder
         XAZCrlEA+5/tbwlq8Bmx2q0HIIXVmigmKsxZD/IVu2peOeOZqvUkqFZmgrjNC1k2ZMbl
         Rt633Tp+AzgUnQ66c0wShyM3HVZooGqY/YjaRTtm6j+fW/uRBT741KXKRSl3+vZkt4nw
         oMGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=wGH4VY/3ugpp7nzWpAp09Rovcx+O4RdGGz99VfpVE0k=;
        b=JfbMKlPF5VavRRiqnIlSuRt9ktTG0dbio7SPokjrOEaOJyzMqQzPVgZrtxIgYaWCg2
         4miMmbuqrXOg+Hch28pG3eyWHN3eNMgUe0Byl8C4ETr7pkR3RKyDEyUKHOuA4Ohc5PGZ
         H45rdpjlpDXrjQxwjMoNL0fFHPh524OMsQCJt79XztSBKq10voA6xqH12e+MGmnc8kgA
         4TVevM2bM2YWsBhV3rv3Txult0+HI2PG8c5e020HTimb+2i/R1iyldkX0Dx97ncEbhMf
         igxukpCwyPr9GPfl6BM7bStSEm1xh4xRgHt2a4ZZXQThQGgZuKT4igEAmLD8ldT41eNZ
         kQZQ==
X-Gm-Message-State: APjAAAWSlGVPY3o5/XWgxVmwp5XOrzs37mPCLvbQSmdRLonPn6rhHe+H
        Y1cQdAvk45zjL0zDZ4ODBHw=
X-Google-Smtp-Source: APXvYqwfnW4Vs+QhrRGYRew3FAdJ0vrdZDXZKbEZ0z9MgIlJXH1IiWUuhUEyeD7TvJXJg9PvvaQgiQ==
X-Received: by 2002:a37:bd85:: with SMTP id n127mr240986qkf.113.1581640714660;
        Thu, 13 Feb 2020 16:38:34 -0800 (PST)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id t23sm2278596qtp.82.2020.02.13.16.38.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Feb 2020 16:38:34 -0800 (PST)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Thu, 13 Feb 2020 19:38:32 -0500
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        linux-efi <linux-efi@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Laszlo Ersek <lersek@redhat.com>,
        Leif Lindholm <leif@nuviainc.com>,
        Peter Jones <pjones@redhat.com>,
        Matthew Garrett <mjg59@google.com>,
        Alexander Graf <agraf@csgraf.de>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Michael Brown <mbrown@fensystems.co.uk>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC PATCH 0/3] efi/x86: add support for generic EFI mixed mode
 boot
Message-ID: <20200214003832.GA3073156@rani.riverdale.lan>
References: <20200213145928.7047-1-ardb@kernel.org>
 <20200213175317.GC1400002@rani.riverdale.lan>
 <CAKv+Gu-78w=gs+D-eS5iBX7e3zL57XBOe1vdW=Bkk=EcA+_FQA@mail.gmail.com>
 <20200213184752.GA1424509@rani.riverdale.lan>
 <CAKv+Gu9Azn9oGHaTqv+-Foj4=b5Y-JradERq4NC5V9XOaVjSKQ@mail.gmail.com>
 <20200214001048.GA3054227@rani.riverdale.lan>
 <20200214001257.GB3054227@rani.riverdale.lan>
 <CAKv+Gu92Tny_PJjddAtLrhdFJm0GqgSfj3NA26PX6xOiaStozg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKv+Gu92Tny_PJjddAtLrhdFJm0GqgSfj3NA26PX6xOiaStozg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-efi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

On Fri, Feb 14, 2020 at 12:21:30AM +0000, Ard Biesheuvel wrote:
> 
> 
> I see the value of having a 64-bit image that can boot natively on
> 32-bit firmware, but I am not expecting any buy in from the distros
> for this scheme.
> 

Ok.
