Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48AC82C2CC2
	for <lists+linux-efi@lfdr.de>; Tue, 24 Nov 2020 17:24:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390275AbgKXQYH (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Tue, 24 Nov 2020 11:24:07 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:32897 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388568AbgKXQYG (ORCPT <rfc822;linux-efi@vger.kernel.org>);
        Tue, 24 Nov 2020 11:24:06 -0500
Received: from [192.168.0.3] (ip5f5af1dc.dynamic.kabel-deutschland.de [95.90.241.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 2C41E20646221;
        Tue, 24 Nov 2020 17:24:05 +0100 (CET)
To:     ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        linux-efi@vger.kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Subject: What to do with `BERT: Error records from previous boot`?
Message-ID: <cab88111-e8a8-5460-bf67-055d3562da10@molgen.mpg.de>
Date:   Tue, 24 Nov 2020 17:24:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Dear Linux folks,


On the Intel Tiger Lake Dell XPS 13 9310 Linux 5.9.9 from Debian 
sid/unstable logged the messages below. Please find the whole log in the 
Linux bug tracker [1].

```
kernel: BERT: Error records from previous boot:
kernel: [Hardware Error]: event severity: fatal
kernel: [Hardware Error]:  Error 0, type: fatal
kernel: [Hardware Error]:   section_type: Firmware Error Record Reference
kernel: [Hardware Error]:   Firmware Error Record Type: SOC Firmware 
Error Record Type2
kernel: [Hardware Error]:   Revision: 2
kernel: [Hardware Error]:   Record Identifier: 
8f87f311-c998-4d9e-a0c4-6065518c4f6d
kernel: [Hardware Error]:   00000000: 0100a306 00000280 ca5824d3 
000003ab  .........$X.....
[…]
```

How can I decode that error to understand what happened?


Kind regards,

Paul


[1]: https://bugzilla.kernel.org/show_bug.cgi?id=210347
