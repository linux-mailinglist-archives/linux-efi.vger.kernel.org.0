Return-Path: <linux-efi-owner@vger.kernel.org>
X-Original-To: lists+linux-efi@lfdr.de
Delivered-To: lists+linux-efi@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6545365EF29
	for <lists+linux-efi@lfdr.de>; Thu,  5 Jan 2023 15:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231878AbjAEOsK (ORCPT <rfc822;lists+linux-efi@lfdr.de>);
        Thu, 5 Jan 2023 09:48:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234092AbjAEOrw (ORCPT
        <rfc822;linux-efi@vger.kernel.org>); Thu, 5 Jan 2023 09:47:52 -0500
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B9341016
        for <linux-efi@vger.kernel.org>; Thu,  5 Jan 2023 06:47:45 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id e13so36306036ljn.0
        for <linux-efi@vger.kernel.org>; Thu, 05 Jan 2023 06:47:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PXulY+pWIwlGwQqIKlBOHZ+2vlznv2jfiN7s1zx/Vv8=;
        b=HQk9PbSGfW6NRZTmQBW4QsK4nnu5t/UZpxfFQOqvWWxKmJxBM6+XctOFBKU4TgnOFq
         Wesmv+90fbFYcH/tqSWrjCWxurX46hCa1OJ6cWMJDNl/lLZLkIa0qcXHbBATU29G/Y0s
         ZmUyToWExl9oCSZFr/S1CLe9e3bI9JHLiuVwQ5rl4/mQlyB4W7QmJDuaAcLfpEJobDwG
         qhqFsmdrIPB1pORTqjQ2fPpx9CpcDm2y8EZ6v5Nqm2h/OnXhzYX7CUHB8cUP9EXr/Jiz
         8R26mFQhsV4O2pvT1JmJ6VC4Re+fQxEqUddXWbjevBAshiJ6c93qd2599PShf0yD1vaC
         NsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PXulY+pWIwlGwQqIKlBOHZ+2vlznv2jfiN7s1zx/Vv8=;
        b=lxSZ9JKBfUVlvzegstiB8ggajKn8iH6AbhkBtU8ZkhhWk9E/Pk4hS+eewy5nxhw+Vr
         Lr13NFEAsxRntDpSL/18hAz7+kPBF4RzEdvymi1+OFDv7mB1oaMq9/TMOrhi7P7xS+Ct
         dQU9H1OCulpRC2GhdbCBtUwbJ/GR6Pl3sVK7mX71vC3qdCk093mGUzg+H1EfORY21r4H
         jC9gUnijnp0lRlMoUMJRw78aH5kZe/NR3KzH8a2wbjsXGeRAxmbi2Bd0nTTmImF/4lRZ
         iEr1RQrwPiCpfdVPeDBKCZR6v/78ei1Tbi6GhLu80FVWFVSrZGYEwSd6B94urzxlFFvs
         zfTw==
X-Gm-Message-State: AFqh2kpSyEZDxdOY8ftY7ugnsHJo1vp3n7DH3glSzcs/7HQu0pDWt9xq
        +QG1kQlAP6CiFxOHGf5RM+UqGA==
X-Google-Smtp-Source: AMrXdXvKDfh3ytIEDjaGfHnzAT6/MTlbDY1OscWQxt7/6flisplLPoNtlNtZXOhEQZynB0rh28QKJQ==
X-Received: by 2002:a2e:505b:0:b0:27f:baa4:e8 with SMTP id v27-20020a2e505b000000b0027fbaa400e8mr10412968ljd.28.1672930063881;
        Thu, 05 Jan 2023 06:47:43 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id h20-20020a05651c125400b0027fb0ce035esm3688362ljh.67.2023.01.05.06.47.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jan 2023 06:47:43 -0800 (PST)
Message-ID: <ae9b9139-46fe-ecaa-1a23-5f0cde9d1256@linaro.org>
Date:   Thu, 5 Jan 2023 16:47:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2 13/17] driver core: Use device's fwnode to check if it
 is waiting for suppliers
Content-Language: en-GB
To:     Saravana Kannan <saravanak@google.com>,
        Abel Vesa <abel.vesa@linaro.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        kernel-team@android.com, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org
References: <20201121020232.908850-1-saravanak@google.com>
 <20201121020232.908850-14-saravanak@google.com> <YrmXpcU1NTYW6T/n@linaro.org>
 <CAGETcx8dwNcZFFzhhv=kMhpuQnyaEekrycpAmGusD-s+qfvA9g@mail.gmail.com>
 <YrskVLshWeps+NXw@linaro.org>
 <CAGETcx8F0wP+RA0KpjOJeZfc=DVG-MbM_=SkRHD4UhD2ReL7Kw@mail.gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <CAGETcx8F0wP+RA0KpjOJeZfc=DVG-MbM_=SkRHD4UhD2ReL7Kw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-efi.vger.kernel.org>
X-Mailing-List: linux-efi@vger.kernel.org

Hi,

On 28/06/2022 21:09, Saravana Kannan wrote:
> On Tue, Jun 28, 2022 at 8:55 AM Abel Vesa <abel.vesa@linaro.org> wrote:
>>
>> On 22-06-27 15:30:25, Saravana Kannan wrote:
>>> On Mon, Jun 27, 2022 at 4:42 AM Abel Vesa <abel.vesa@linaro.org> wrote:
>>>>
>>>> On 20-11-20 18:02:28, Saravana Kannan wrote:
>>>>> To check if a device is still waiting for its supplier devices to be
>>>>> added, we used to check if the devices is in a global
>>>>> waiting_for_suppliers list. Since the global list will be deleted in
>>>>> subsequent patches, this patch stops using this check.
>>>>>
>>>>> Instead, this patch uses a more device specific check. It checks if the
>>>>> device's fwnode has any fwnode links that haven't been converted to
>>>>> device links yet.
>>>>>
>>>>> Signed-off-by: Saravana Kannan <saravanak@google.com>
>>>>> ---
>>>>>   drivers/base/core.c | 18 ++++++++----------
>>>>>   1 file changed, 8 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/drivers/base/core.c b/drivers/base/core.c
>>>>> index 395dece1c83a..1873cecb0cc4 100644
>>>>> --- a/drivers/base/core.c
>>>>> +++ b/drivers/base/core.c
>>>>> @@ -51,6 +51,7 @@ static DEFINE_MUTEX(wfs_lock);
>>>>>   static LIST_HEAD(deferred_sync);
>>>>>   static unsigned int defer_sync_state_count = 1;
>>>>>   static DEFINE_MUTEX(fwnode_link_lock);
>>>>> +static bool fw_devlink_is_permissive(void);
>>>>>
>>>>>   /**
>>>>>    * fwnode_link_add - Create a link between two fwnode_handles.
>>>>> @@ -995,13 +996,13 @@ int device_links_check_suppliers(struct device *dev)
>>>>>         * Device waiting for supplier to become available is not allowed to
>>>>>         * probe.
>>>>>         */
>>>>> -     mutex_lock(&wfs_lock);
>>>>> -     if (!list_empty(&dev->links.needs_suppliers) &&
>>>>> -         dev->links.need_for_probe) {
>>>>> -             mutex_unlock(&wfs_lock);
>>>>> +     mutex_lock(&fwnode_link_lock);
>>>>> +     if (dev->fwnode && !list_empty(&dev->fwnode->suppliers) &&
>>>>> +         !fw_devlink_is_permissive()) {
>>>>> +             mutex_unlock(&fwnode_link_lock);
>>>>
>>>> Hi Saravana,
>>>>
>>>> First of, sorry for going back to this.
>>>
>>> No worries at all. If there's an issue with fw_devlink, I want to have it fixed.
>>>
>>>> There is a scenario where this check will not work and probably should
>>>> work. It goes like this:
>>>>
>>>> A clock controller is not allowed to probe because it uses a clock from a child device of a
>>>> consumer, like so:
>>>>
>>>>          dispcc: clock-controller@af00000 {
>>>>                  clocks = <&dsi0_phy 0>;
>>>>          };
>>>>
>>>>          mdss: mdss@ae00000 {
>>>>                  clocks = <&dispcc DISP_CC_MDSS_MDP_CLK>;
>>>>
>>>>                  dsi0_phy: dsi-phy@ae94400 {
>>>>                          clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
>>>>                  };
>>>>          };
>>>>
>>>> This is a real scenario actually, but I stripped it down to the essentials.
>>>
>>> I'm well aware of this scenario and explicitly wrote code to address this :)
>>>
>>
>> Actually, the problem seems to be when you have two dsi phys.
>> Like so:
>>
>>           dispcc: clock-controller@af00000 {
>>                   clocks = <&dsi0_phy 0>;
>>                   clocks = <&dsi1_phy 0>;
>>           };
>>
>>           mdss: mdss@ae00000 {
>>                   clocks = <&dispcc DISP_CC_MDSS_MDP_CLK>;
>>
>>                   dsi0_phy: dsi-phy@ae94400 {
>>                           clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
>>                   };
>>
>>                   dsi1_phy: dsi-phy@ae64400 {
>>                           clocks = <&dispcc DISP_CC_MDSS_AHB_CLK>,
>>                   };
>>           };
>>
>> And from what I've seen happening so far is that the device_is_dependent
>> check for the parent of the supplier (if it also a consumer) seems to return
>> false on second pass of the same link due to the DL_FLAG_SYNC_STATE_ONLY
>> being set this time around.
>>
>>> See this comment in fw_devlink_create_devlink()
>>>
>>>         /*
>>>           * If we can't find the supplier device from its fwnode, it might be
>>>           * due to a cyclic dependency between fwnodes. Some of these cycles can
>>>           * be broken by applying logic. Check for these types of cycles and
>>>           * break them so that devices in the cycle probe properly.
>>>           *
>>>           * If the supplier's parent is dependent on the consumer, then the
>>>           * consumer and supplier have a cyclic dependency. Since fw_devlink
>>>           * can't tell which of the inferred dependencies are incorrect, don't
>>>           * enforce probe ordering between any of the devices in this cyclic
>>>           * dependency. Do this by relaxing all the fw_devlink device links in
>>>           * this cycle and by treating the fwnode link between the consumer and
>>>           * the supplier as an invalid dependency.
>>>           */
>>>
>>
>> So when this thing you mentioned above is happening for the second dsi
>> phy (order doesn't matter), since the dsi phy itself cannot be found,
>> the device_is_dependent is run for the same link: dispcc -> mdss
>> (supplier -> consumer), but again, since it has the
>> DL_FLAG_SYNC_STATE_ONLY this time around, it will skip that specific
>> link.
> 
> Ugh... I knew there was this gap, but didn't expect it to be a real world issue.
> 
> There are different ways of addressing this and they all fall
> somewhere within a spectrum of:
> "stop enforcing very specific edges of the dependency graph when you
> find a cycles"
> To
> "just don't enforce any dependency for devices in a cycle and let the
> drivers figure out when to -EPROBE_DEFER".
> 
> And each of those are of varying complexity. Ideally I'd prefer to
> relax specific edges, but I need to balance it out with the code
> complexity. Let me soak this for a few weeks to decide on what option
> to take.

I wanted to check if there is any progress on this topic? It appears 
that few weeks turned into few months already and the issue is still 
present. If not, can we please re-consider applying [1] while Saravana 
is working on a better fix?

[1] 
https://lore.kernel.org/all/20211125183622.597177-1-dmitry.baryshkov@linaro.org/

> 
> Thanks for the report.
> 
> -Saravana
> 
>>
>>> Applying this comment to your example, dispcc is the "consumer",
>>> dsi0_phy is the "supplier" and mdss is the "supplier's parent".
>>>
>>> And because we can't guarantee the order of addition of these top
>>> level devices is why I also have this piece of recursive call inside
>>> __fw_devlink_link_to_suppliers():
>>>
>>>                  /*
>>>                   * If a device link was successfully created to a supplier, we
>>>                   * now need to try and link the supplier to all its suppliers.
>>>                   *
>>>                   * This is needed to detect and delete false dependencies in
>>>                   * fwnode links that haven't been converted to a device link
>>>                   * yet. See comments in fw_devlink_create_devlink() for more
>>>                   * details on the false dependency.
>>>                   *
>>>                   * Without deleting these false dependencies, some devices will
>>>                   * never probe because they'll keep waiting for their false
>>>                   * dependency fwnode links to be converted to device links.
>>>                   */
>>>                  sup_dev = get_dev_from_fwnode(sup);
>>>                  __fw_devlink_link_to_suppliers(sup_dev, sup_dev->fwnode);
>>>                  put_device(sup_dev);
>>>
>>> So when mdss gets added, we'll link it to dispcc and then check if
>>> dispcc has any suppliers it needs to link to. And that's when the
>>> logic will catch the cycle and fix it.
>>>
>>> Can you tell me why this wouldn't unblock the probing of dispcc? Are
>>> you actually hitting this on a device? If so, can you please check why
>>> this logic isn't sufficient to catch and undo the cycle?
>>>
>>
>> This is happening on Qualcomm SDM845 with Linus's tree.
>>
>>> Thanks,
>>> Saravana
>>>
>>>> So, the dsi0_phy will be "device_add'ed" (through of_platform_populate) by the mdss probe.
>>>> The mdss will probe defer waiting for the DISP_CC_MDSS_MDP_CLK, while
>>>> the dispcc will probe defer waiting for the dsi0_phy (supplier).
>>>>
>>>> Basically, this 'supplier availability check' does not work when a supplier might
>>>> be populated by a consumer of the device that is currently trying to probe.
>>>>
>>>>
>>>> Abel
>>>>
>>>>
>>>>>                return -EPROBE_DEFER;
>>>>>        }
>>>>> -     mutex_unlock(&wfs_lock);
>>>>> +     mutex_unlock(&fwnode_link_lock);
>>>>>
>>>>>        device_links_write_lock();
>>>>>
>>>>> @@ -1167,10 +1168,7 @@ static ssize_t waiting_for_supplier_show(struct device *dev,
>>>>>        bool val;
>>>>>
>>>>>        device_lock(dev);
>>>>> -     mutex_lock(&wfs_lock);
>>>>> -     val = !list_empty(&dev->links.needs_suppliers)
>>>>> -           && dev->links.need_for_probe;
>>>>> -     mutex_unlock(&wfs_lock);
>>>>> +     val = !list_empty(&dev->fwnode->suppliers);
>>>>>        device_unlock(dev);
>>>>>        return sysfs_emit(buf, "%u\n", val);
>>>>>   }
>>>>> @@ -2202,7 +2200,7 @@ static int device_add_attrs(struct device *dev)
>>>>>                        goto err_remove_dev_groups;
>>>>>        }
>>>>>
>>>>> -     if (fw_devlink_flags && !fw_devlink_is_permissive()) {
>>>>> +     if (fw_devlink_flags && !fw_devlink_is_permissive() && dev->fwnode) {
>>>>>                error = device_create_file(dev, &dev_attr_waiting_for_supplier);
>>>>>                if (error)
>>>>>                        goto err_remove_dev_online;
>>>>> --
>>>>> 2.29.2.454.gaff20da3a2-goog
>>>>>
>>>>>
>>>

-- 
With best wishes
Dmitry

